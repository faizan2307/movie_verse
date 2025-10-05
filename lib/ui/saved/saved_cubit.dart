import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/db/drift_db.dart';
import '../../domain/repositories/movie_repository.dart';

class SavedState {
  final List<MovieRow> movies;
  final bool loading;
  final Object? error;
  final SavedSort sort;
  final bool grid; // true: grid, false: list
  const SavedState({this.movies = const [], this.loading = true, this.error, this.sort = SavedSort.dateDesc, this.grid = true});
  SavedState copyWith({List<MovieRow>? movies, bool? loading, Object? error, SavedSort? sort, bool? grid}) =>
      SavedState(movies: movies ?? this.movies, loading: loading ?? this.loading, error: error, sort: sort ?? this.sort, grid: grid ?? this.grid);
}

enum SavedSort { dateDesc, titleAsc }

class SavedCubit extends Cubit<SavedState> {
  final MovieRepository repo;
  StreamSubscription? _sub;
  SavedCubit(this.repo) : super(const SavedState()) {
    _sub = repo.watchBookmarks().listen(
          (data) => emit(state.copyWith(movies: _applySort(data, state.sort), loading: false)),
      onError: (e) => emit(state.copyWith(loading: false, error: e)),
    );
  }

  void setSort(SavedSort sort) {
    emit(state.copyWith(sort: sort, movies: _applySort(state.movies, sort)));
  }

  Future<void> remove(int id) => repo.toggleBookmark(id);
  Future<void> undo(int id) => repo.toggleBookmark(id);
  Future<void> clearAll() => repo.clearBookmarks();
  void toggleLayout() => emit(state.copyWith(grid: !state.grid));

  @override
  Future<void> close() { _sub?.cancel(); return super.close(); }
}

List<MovieRow> _applySort(List<MovieRow> input, SavedSort sort) {
  final list = [...input];
  switch (sort) {
    case SavedSort.dateDesc:
      // Sort by savedAt in descending order (newest first)
      list.sort((a, b) {
        if (a.savedAt == null && b.savedAt == null) return 0;
        if (a.savedAt == null) return 1;
        if (b.savedAt == null) return -1;
        return b.savedAt!.compareTo(a.savedAt!);
      });
      return list;
    case SavedSort.titleAsc:
      list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      return list;
  }
}
