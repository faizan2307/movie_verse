import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/ui/details/details_cubit.dart';

import '../../helper/mocks.mocks.dart';

void main() {
  late MockMovieRepository repo;
  late StreamController<MovieRow?> movieStream;
  late StreamController<bool> savedStream;

  setUp(() {
    repo = MockMovieRepository();
    movieStream = StreamController<MovieRow?>();
    savedStream = StreamController<bool>();

    when(repo.watchMovie(99)).thenAnswer((_) => movieStream.stream);
    when(repo.watchIsBookmarked(99)).thenAnswer((_) => savedStream.stream);
    when(repo.refreshMovie(99)).thenAnswer((_) async {});
    when(repo.toggleBookmark(99)).thenAnswer((_) async {});
  });

  tearDown(() async {
    await movieStream.close();
    await savedStream.close();
  });

  blocTest<DetailsCubit, DetailsState>(
    'loads movie and saved state',
    build: () => DetailsCubit(repo, 99),
    act: (c) async {
      movieStream.add(MovieRow(id: 99, title: 'Z', overview: null, posterPath: null, voteAverage: null, releaseDate: null));
      savedStream.add(true);
      await Future<void>.delayed(const Duration(milliseconds: 1));
    },
    expect: () => [
      isA<DetailsState>().having((s) => s.loading, 'loading', false).having((s) => s.movie?.id, 'id', 99),
      isA<DetailsState>().having((s) => s.isSaved, 'isSaved', true),
    ],
    verify: (_) => verify(repo.refreshMovie(99)).called(1),
  );

  blocTest<DetailsCubit, DetailsState>(
    'toggle bookmark delegates to repo',
    build: () => DetailsCubit(repo, 99),
    act: (c) => c.toggle(),
    verify: (_) => verify(repo.toggleBookmark(99)).called(1),
  );
}
