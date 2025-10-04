import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../core/db/drift_db.dart';

class DetailsState {
  final MovieRow? movie;
  final bool isSaved;
  final bool loading;
  final Object? error;
  const DetailsState({this.movie, this.isSaved = false, this.loading = true, this.error});

  DetailsState copyWith({MovieRow? movie, bool? isSaved, bool? loading, Object? error}) =>
      DetailsState(
        movie: movie ?? this.movie,
        isSaved: isSaved ?? this.isSaved,
        loading: loading ?? this.loading,
        error: error,
      );
}

class DetailsCubit extends Cubit<DetailsState> {
  final MovieRepository repo;
  final int id;
  StreamSubscription? _subMovie;
  StreamSubscription? _subSaved;

  DetailsCubit(this.repo, this.id) : super(const DetailsState()) {
    _subMovie = repo.watchMovie(id).listen(
          (m) => emit(state.copyWith(movie: m, loading: false)),
      onError: (e) => emit(state.copyWith(loading: false, error: e)),
    );
    _subSaved = repo.watchIsBookmarked(id).listen(
          (s) => emit(state.copyWith(isSaved: s)),
      onError: (e) => emit(state.copyWith(error: e)),
    );
    refresh();
  }

  Future<void> refresh() async {
    try { await repo.refreshMovie(id); } catch (e) { emit(state.copyWith(loading: false, error: e)); }
  }

  Future<void> toggle() => repo.toggleBookmark(id);

  @override
  Future<void> close() { _subMovie?.cancel(); _subSaved?.cancel(); return super.close(); }
}
