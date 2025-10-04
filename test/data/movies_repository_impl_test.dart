import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:movie_verse/data/repositories/movie_repository_impl.dart';
import 'package:movie_verse/core/network/tmdb_api.dart';
import 'package:movie_verse/core/network/models/dto_movie.dart';
import 'package:movie_verse/core/network/models/dto_paged.dart';
import 'package:movie_verse/core/network/models/dto_movie_details.dart';
import 'package:movie_verse/core/db/drift_db.dart';

import '../helper/mocks.mocks.dart';

void main() {
  late MockTmdbApi api;
  late MockAppDatabase db;
  late MovieRepositoryImpl repo;

  setUp(() {
    api = MockTmdbApi();
    db = MockAppDatabase();
    repo = MovieRepositoryImpl(db, api);
  });

  group('refreshTrending', () {
    test('upserts movies and replaces trending ids', () async {
      when(api.trending(1)).thenAnswer((_) async => PagedResponse<MovieDto>(
        page: 1, totalPages: 1, totalResults: 2,
        results: [
          MovieDto(id: 10, title: 'A'),
          MovieDto(id: 20, title: 'B'),
        ],
      ));

      when(db.upsertMovies(any)).thenAnswer((_) async {});
      when(db.replaceTrending(any, page: anyNamed('page'))).thenAnswer((_) async {});

      await repo.refreshTrending(page: 1);

      verify(api.trending(1)).called(1);
      verify(db.upsertMovies(argThat(isA<Iterable<MoviesCompanion>>()))).called(1);
      verify(db.replaceTrending([10, 20], page: 1)).called(1);
      verifyNoMoreInteractions(db);
    });
  });

  group('refreshNowPlaying', () {
    test('upserts movies and replaces now playing ids', () async {
      when(api.nowPlaying(1)).thenAnswer((_) async => PagedResponse<MovieDto>(
        page: 1, totalPages: 1, totalResults: 1,
        results: [MovieDto(id: 7, title: 'Now')],
      ));

      when(db.upsertMovies(any)).thenAnswer((_) async {});
      when(db.replaceNowPlaying(any, page: anyNamed('page'))).thenAnswer((_) async {});

      await repo.refreshNowPlaying(page: 1);

      verify(api.nowPlaying(1)).called(1);
      verify(db.upsertMovies(any)).called(1);
      verify(db.replaceNowPlaying([7], page: 1)).called(1);
    });
  });

  group('refreshMovie', () {
    test('upserts movie details', () async {
      when(api.details(99)).thenAnswer((_) async => MovieDetailsDto(id: 99, title: 'Z'));
      when(db.upsertMovies(any)).thenAnswer((_) async {});

      await repo.refreshMovie(99);

      verify(api.details(99)).called(1);
      verify(db.upsertMovies(any)).called(1);
    });
  });

  group('refreshSearch', () {
    test('ignores blank query', () async {
      await repo.refreshSearch('   ');
      verifyZeroInteractions(api);
      verifyZeroInteractions(db);
    });

    test('upserts movies and sets ordered search result ids', () async {
      when(api.search('x', 1, false)).thenAnswer((_) async => PagedResponse<MovieDto>(
        page: 1, totalPages: 1, totalResults: 2,
        results: [MovieDto(id: 3, title: 'x1'), MovieDto(id: 4, title: 'x2')],
      ));
      when(db.upsertMovies(any)).thenAnswer((_) async {});
      when(db.setSearchResults(any, any)).thenAnswer((_) async {});

      await repo.refreshSearch('x');

      verify(api.search('x', 1, false)).called(1);
      verify(db.upsertMovies(any)).called(1);
      verify(db.setSearchResults('x', [3,4])).called(1);
    });
  });
}
