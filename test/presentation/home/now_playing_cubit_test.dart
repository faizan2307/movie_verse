import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/ui/home/now_playing_cubit.dart';
import '../../helper/mocks.mocks.dart';


void main() {
  late MockMovieRepository repo;
  late StreamController<List<MovieRow>> stream;

  setUp(() {
    repo = MockMovieRepository();
    stream = StreamController<List<MovieRow>>();
    when(repo.watchNowPlaying(page: anyNamed('page'))).thenAnswer((_) => stream.stream);
    when(repo.refreshNowPlaying(page: anyNamed('page'))).thenAnswer((_) => Future.value());

  });

  tearDown(() async => stream.close());

  blocTest<NowPlayingCubit, NowPlayingState>(
    'emits movies on stream',
    build: () => NowPlayingCubit(repo),
    act: (c) async {
      stream.add([MovieRow(id: 5, title: 'X', overview: null, posterPath: null, voteAverage: null, releaseDate: null)]);
      await Future<void>.delayed(const Duration(milliseconds: 1));
    },
    expect: () => [
      isA<NowPlayingState>().having((s) => s.loading, 'loading', false).having((s) => s.movies.single.id, 'id', 5),
    ],
    verify: (_) => verify(repo.refreshNowPlaying(page: 1)).called(1),
  );
}
