import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/db/drift_db.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../core/util/debounce.dart';

sealed class SearchEvent {}
class SearchQueryChanged extends SearchEvent { final String query; SearchQueryChanged(this.query); }
class _SearchResultsArrived extends SearchEvent { final List<MovieRow> results; _SearchResultsArrived(this.results); }
class _SearchFailed extends SearchEvent { final Object error; _SearchFailed(this.error); }

class SearchState {
  final String query;
  final List<MovieRow> results;
  final bool loading;
  final Object? error;

  const SearchState({this.query = '', this.results = const [], this.loading = false, this.error});
  SearchState copyWith({String? query, List<MovieRow>? results, bool? loading, Object? error}) =>
      SearchState(query: query ?? this.query, results: results ?? this.results, loading: loading ?? this.loading, error: error);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MovieRepository repo;
  StreamSubscription? _sub;
  final _deb = Debouncer(const Duration(milliseconds: 500));

  SearchBloc(this.repo) : super(const SearchState()) {
    on<SearchQueryChanged>((e, emit) async {
      final q = e.query.trim().toLowerCase();
      if (q.isEmpty) {
        await _sub?.cancel();
        emit(state.copyWith(query: '', results: const [], loading: false));
        return;
      }
      emit(state.copyWith(query: q, loading: true));
      _deb(() async {
        try {
          await repo.refreshSearch(q);
          await _subscribeTo(q);
        } catch (err) {
          add(_SearchFailed(err));
        }
      });
    });

    on<_SearchResultsArrived>((e, emit) {
      emit(state.copyWith(results: e.results, loading: false));
    });

    on<_SearchFailed>((e, emit) {
      emit(state.copyWith(loading: false, error: e.error));
    });
  }

  Future<void> _subscribeTo(String q) async {
    await _sub?.cancel();
    _sub = repo.watchSearch(q).listen(
      (data) => add(_SearchResultsArrived(data)),
      onError: (e) => add(_SearchFailed(e)),
    );
  }

  @override
  Future<void> close() { _sub?.cancel(); _deb.dispose(); return super.close(); }
}
