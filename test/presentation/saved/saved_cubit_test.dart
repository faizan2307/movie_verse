import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/ui/saved/saved_cubit.dart';

import '../../helper/mocks.mocks.dart';

void main() {
  late MockMovieRepository repo;
  late StreamController<List<MovieRow>> stream;

  setUp(() {
    repo = MockMovieRepository();
    stream = StreamController<List<MovieRow>>();
    when(repo.watchBookmarks()).thenAnswer((_) => stream.stream);
  });

  tearDown(() async => stream.close());

  blocTest<SavedCubit, SavedState>(
    'emits saved movies when stream fires',
    build: () => SavedCubit(repo),
    act: (c) async {
      stream.add([MovieRow(id: 5, title: 'Saved', overview: null, posterPath: null, voteAverage: null, releaseDate: null)]);
      await Future<void>.delayed(const Duration(milliseconds: 1));
    },
    expect: () => [
      isA<SavedState>().having((s) => s.loading, 'loading', false).having((s) => s.movies.single.id, 'id', 5),
    ],
  );
}
