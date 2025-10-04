import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/ui/search/search_bloc.dart';
import '../../helper/mocks.mocks.dart';

void main() {
  late MockMovieRepository repo;
  late StreamController<List<MovieRow>> stream;

  setUp(() {
    repo = MockMovieRepository();
    stream = StreamController<List<MovieRow>>();
    when(repo.refreshSearch(any, page: anyNamed('page'))).thenAnswer((_) async {});
    when(repo.watchSearch(any, page: anyNamed('page'))).thenAnswer((_) => stream.stream);
  });

  tearDown(() async => stream.close());

  blocTest<SearchBloc, SearchState>(
    'debounces and emits results',
    build: () => SearchBloc(repo),
    act: (b) async {
      b.add(SearchQueryChanged('bat'));
      await Future<void>.delayed(const Duration(milliseconds: 600)); // > debounce(500)
      stream.add([MovieRow(id: 1, title: 'Batman', overview: null, posterPath: null, voteAverage: null, releaseDate: null)]);
      await Future<void>.delayed(const Duration(milliseconds: 10));
    },
    expect: () => [
      isA<SearchState>().having((s) => s.query, 'query', 'bat').having((s) => s.loading, 'loading', true),
      isA<SearchState>().having((s) => s.loading, 'loading', false).having((s) => s.results.length, 'len', 1),
    ],
    verify: (_) => verify(repo.refreshSearch('bat', page: 1)).called(1),
  );
}
