import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/db/drift_db.dart';
import '../../domain/repositories/movie_repository.dart';

class NowPlayingState {
  final List<MovieRow> movies;
  final bool loading;
  final Object? error;
  final int page;
  final bool endReached;
  const NowPlayingState({this.movies = const [], this.loading = true, this.error, this.page = 1, this.endReached = false});
  NowPlayingState copyWith({List<MovieRow>? movies, bool? loading, Object? error, int? page, bool? endReached}) =>
      NowPlayingState(movies: movies ?? this.movies, loading: loading ?? this.loading, error: error, page: page ?? this.page, endReached: endReached ?? this.endReached);
}

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MovieRepository repo;
  StreamSubscription? _sub;
  NowPlayingCubit(this.repo) : super(const NowPlayingState()) {
    _sub = repo.watchNowPlayingUpTo(upToPage: 1).listen(
          (data) => emit(state.copyWith(movies: data, loading: false)),
      onError: (e) => emit(state.copyWith(loading: false, error: e)),
    );
    refresh();
  }

  Future<void> refresh() async {
    try {
      final end = await repo.refreshNowPlaying();
      emit(state.copyWith(endReached: end));
    } catch (e) { emit(state.copyWith(loading: false, error: e)); }
  }

  Future<void> loadMore() async {
    if (state.loading || state.endReached) return;
    emit(state.copyWith(loading: true));
    final next = state.page + 1;
    try {
      final end = await repo.refreshNowPlaying(page: next);
      _sub?.cancel();
      _sub = repo.watchNowPlayingUpTo(upToPage: next).listen(
            (data) => emit(state.copyWith(movies: data, loading: false, page: next, endReached: end)),
        onError: (e) => emit(state.copyWith(loading: false, error: e)),
      );
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  @override
  Future<void> close() { _sub?.cancel(); return super.close(); }
}
