import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../core/db/drift_db.dart';
import '../../core/db/mappers.dart';
import '../../core/network/tmdb_api.dart';
import '../../domain/repositories/movie_repository.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final AppDatabase db;
  final TmdbApi api;

  MovieRepositoryImpl(this.db, this.api);

  // Streams (all from DB)
  @override
  Stream<List<MovieRow>> watchTrending({int page = 1}) =>
      db.watchTrendingMovies(page: page);

  @override
  Stream<List<MovieRow>> watchNowPlaying({int page = 1}) =>
      db.watchNowPlayingMovies(page: page);

  @override
  Stream<List<MovieRow>> watchTrendingUpTo({int upToPage = 1}) =>
      db.watchTrendingMoviesUpTo(upToPage: upToPage);

  @override
  Stream<List<MovieRow>> watchNowPlayingUpTo({int upToPage = 1}) =>
      db.watchNowPlayingMoviesUpTo(upToPage: upToPage);

  @override
  Stream<List<MovieRow>> watchBookmarks() => db.watchBookmarks();

  @override
  Stream<MovieRow?> watchMovie(int id) => db.watchMovie(id);

  @override
  Stream<bool> watchIsBookmarked(int id) => db.watchIsBookmarked(id);

  // Mutations
  @override
  Future<void> toggleBookmark(int id) => db.toggleBookmark(id);

  @override
  Future<void> clearBookmarks() => db.clearBookmarks();

  // Refreshers (network → db)
  @override
  Future<bool> refreshTrending({int page = 1}) async {
    final res = await api.trending(page);
    await db.upsertMovies(res.results.map(movieDtoToCompanion));
    await db.replaceTrending(res.results.map((e) => e.id).toList(), page: page);
    return res.results.isEmpty || res.page >= res.totalPages;
  }

  @override
  Future<bool> refreshNowPlaying({int page = 1}) async {
    final res = await api.nowPlaying(page);
    await db.upsertMovies(res.results.map(movieDtoToCompanion));
    await db.replaceNowPlaying(res.results.map((e) => e.id).toList(), page: page);
    return res.results.isEmpty || res.page >= res.totalPages;
  }

  @override
  Future<void> refreshMovie(int id) async {
    final res = await api.details(id);
    await db.upsertMovies([movieDetailsToCompanion(res)]);
  }

  @override
  Future<void> refreshSearch(String query, {int page = 1}) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return;
    final res = await api.search(q, page, false);
    await db.upsertMovies(res.results.map(movieDtoToCompanion));
    await db.setSearchResults(q, res.results.map((e) => e.id).toList());
  }

  @override
  Stream<List<MovieRow>> watchSearch(String query, {int page = 1}) {
    final normalized = query.trim().toLowerCase();
    // We persist ordered IDs per-query in SearchResults; join to Movies and stream
    final q = db.select(db.searchResults).join([
      innerJoin(db.movies, db.movies.id.equalsExp(db.searchResults.movieId)),
    ])
      ..where(db.searchResults.query.equals(normalized))
      ..orderBy([OrderingTerm.asc(db.searchResults.position)]);

    return q.watch().map(
          (rows) => rows.map((r) => MovieRow.fromTable(r.readTable(db.movies))).toList(),
    );
  }
}
