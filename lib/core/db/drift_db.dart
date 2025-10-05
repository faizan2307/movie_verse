import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'drift_db.g.dart';

@DriftDatabase(tables: [Movies, Trending, NowPlaying, Bookmarks, SearchResults])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_open());
  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(movies, movies.runtime);
            await m.addColumn(movies, movies.genresCsv);
          }
        },
      );

  // --- Mutations ---
  Future<void> upsertMovies(Iterable<MoviesCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(movies, rows.toList()));
  }

  Future<void> replaceTrending(List<int> ids, {int page = 1}) async {
    await transaction(() async {
      await (delete(trending)..where((t) => t.page.equals(page))).go();
      var pos = 0;
      await batch((b) => b.insertAll(
        trending,
        ids
            .map((id) => TrendingCompanion(
          position: Value(pos++),
          page: Value(page),
          movieId: Value(id),
        ))
            .toList(),
      ));
    });
  }

  Future<void> replaceNowPlaying(List<int> ids, {int page = 1}) async {
    await transaction(() async {
      await (delete(nowPlaying)..where((t) => t.page.equals(page))).go();
      var pos = 0;
      await batch((b) => b.insertAll(
        nowPlaying,
        ids
            .map((id) => NowPlayingCompanion(
          position: Value(pos++),
          page: Value(page),
          movieId: Value(id),
        ))
            .toList(),
      ));
    });
  }

  Future<void> setSearchResults(String q, List<int> ids) async {
    await transaction(() async {
      await (delete(searchResults)..where((s) => s.query.equals(q))).go();
      var pos = 0;
      await batch((b) => b.insertAll(
        searchResults,
        ids
            .map((id) => SearchResultsCompanion(
          query: Value(q),
          position: Value(pos++),
          movieId: Value(id),
        ))
            .toList(),
      ));
    });
  }

  Future<void> toggleBookmark(int movieId) async {
    final existing = await (select(bookmarks)..where((b) => b.movieId.equals(movieId))).getSingleOrNull();
    if (existing == null) {
      await into(bookmarks).insert(BookmarksCompanion(movieId: Value(movieId)));
    } else {
      await (delete(bookmarks)..where((b) => b.movieId.equals(movieId))).go();
    }
  }

  Future<void> clearBookmarks() async {
    await delete(bookmarks).go();
  }

  // --- Streams (domain-friendly shape provided below) ---
  Stream<List<MovieRow>> watchTrendingMovies({int page = 1}) {
    final q = select(trending).join([
      innerJoin(movies, movies.id.equalsExp(trending.movieId)),
    ])
      ..where(trending.page.equals(page))
      ..orderBy([OrderingTerm.asc(trending.position)]);

    return q.watch().map((rows) => rows.map((r) => MovieRow.fromTable(r.readTable(movies))).toList());
  }

  Stream<List<MovieRow>> watchTrendingMoviesUpTo({int upToPage = 1}) {
    final q = select(trending).join([
      innerJoin(movies, movies.id.equalsExp(trending.movieId)),
    ])
      ..where(trending.page.isSmallerOrEqualValue(upToPage))
      ..orderBy([OrderingTerm.asc(trending.page), OrderingTerm.asc(trending.position)]);

    return q.watch().map((rows) => rows.map((r) => MovieRow.fromTable(r.readTable(movies))).toList());
  }

  Stream<List<MovieRow>> watchNowPlayingMovies({int page = 1}) {
    final q = select(nowPlaying).join([
      innerJoin(movies, movies.id.equalsExp(nowPlaying.movieId)),
    ])
      ..where(nowPlaying.page.equals(page))
      ..orderBy([OrderingTerm.asc(nowPlaying.position)]);

    return q.watch().map((rows) => rows.map((r) => MovieRow.fromTable(r.readTable(movies))).toList());
  }

  Stream<List<MovieRow>> watchNowPlayingMoviesUpTo({int upToPage = 1}) {
    final q = select(nowPlaying).join([
      innerJoin(movies, movies.id.equalsExp(nowPlaying.movieId)),
    ])
      ..where(nowPlaying.page.isSmallerOrEqualValue(upToPage))
      ..orderBy([OrderingTerm.asc(nowPlaying.page), OrderingTerm.asc(nowPlaying.position)]);

    return q.watch().map((rows) => rows.map((r) => MovieRow.fromTable(r.readTable(movies))).toList());
  }

  Stream<List<MovieRow>> watchBookmarks() {
    final q = select(bookmarks).join([
      innerJoin(movies, movies.id.equalsExp(bookmarks.movieId)),
    ])..orderBy([OrderingTerm.desc(bookmarks.savedAt)]);

    // return q.watch().map((rows) => rows.map((r) => MovieRow.fromTable(r.readTable(movies))).toList());
    return q.watch().map((rows) => rows.map((r) =>
      MovieRow.fromTableWithSavedAt(
        r.readTable(movies),
        r.readTable(bookmarks).savedAt
      )
    ).toList());
  }

  Stream<MovieRow?> watchMovie(int id) {
    return (select(movies)..where((m) => m.id.equals(id)))
        .watchSingleOrNull()
        .map((row) => row == null ? null : MovieRow.fromTable(row));
  }

  Stream<bool> watchIsBookmarked(int id) {
    return (select(bookmarks)..where((b) => b.movieId.equals(id)))
        .watch()
        .map((rows) => rows.isNotEmpty);
  }
}

// DB opener
LazyDatabase _open() => LazyDatabase(() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(p.join(dir.path, 'app.db'));
  return NativeDatabase.createInBackground(file);
});

// Minimal domain projection (pure data class)
class MovieRow {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final String? releaseDate;
  final int? runtime;
  final List<String> genres;
  final DateTime? savedAt; // For sorting saved movies

  MovieRow({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
    this.runtime,
    this.genres = const [],
    this.savedAt,
  });

  factory MovieRow.fromTable(DbMovie m) => MovieRow(
    id: m.id,
    title: m.title ?? '',
    overview: m.overview,
    posterPath: m.posterPath,
    voteAverage: m.voteAverage,
    releaseDate: m.releaseDate,
    runtime: m.runtime,
    genres: _splitGenres(m.genresCsv),
  );

  factory MovieRow.fromTableWithSavedAt(DbMovie m, DateTime savedAt) => MovieRow(
    id: m.id,
    title: m.title ?? '',
    overview: m.overview,
    posterPath: m.posterPath,
    voteAverage: m.voteAverage,
    releaseDate: m.releaseDate,
    runtime: m.runtime,
    genres: _splitGenres(m.genresCsv),
    savedAt: savedAt,
  );
}

List<String> _splitGenres(String? csv) {
  if (csv == null || csv.trim().isEmpty) return const [];
  return csv.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
}
