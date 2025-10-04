import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/ui/home/trending_cubit.dart';

import '../../helper/mocks.mocks.dart';

void main() {
  late MockMovieRepository repo;
  late StreamController<List<MovieRow>> stream;

  List<MovieRow> sample() => [
    MovieRow(id: 1, title: 'A', overview: null, posterPath: null, voteAverage: null, releaseDate: null),
    MovieRow(id: 2, title: 'B', overview: null, posterPath: null, voteAverage: null, releaseDate: null),
  ];

  setUp(() {
    repo = MockMovieRepository();
    stream = StreamController<List<MovieRow>>();
    when(repo.watchTrending(page: anyNamed('page'))).thenAnswer((_) => stream.stream);
    when(repo.refreshTrending(page: anyNamed('page'))).thenAnswer((_) => Future.value());
  });

  tearDown(() async {
    await stream.close();
  });

  blocTest<TrendingCubit, TrendingState>(
    'emits loading=false with movies when stream emits',
    build: () => TrendingCubit(repo),
    act: (c) async {
      stream.add(sample());
      await Future<void>.delayed(const Duration(milliseconds: 1));
    },
    expect: () => [
      // initial state is loading:true; after stream data => loading:false
      isA<TrendingState>().having((s) => s.loading, 'loading', false).having((s) => s.movies.length, 'len', 2),
    ],
    verify: (_) {
      verify(repo.refreshTrending(page: 1)).called(1);
    },
  );
}
