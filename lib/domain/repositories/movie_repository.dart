import '../../core/db/drift_db.dart';

abstract class MovieRepository {
  // Streams (UI listens to DB; always offline-first)
  Stream<List<MovieRow>> watchTrending({int page = 1});
  Stream<List<MovieRow>> watchNowPlaying({int page = 1});
  Stream<List<MovieRow>> watchTrendingUpTo({int upToPage = 1});
  Stream<List<MovieRow>> watchNowPlayingUpTo({int upToPage = 1});
  Stream<List<MovieRow>> watchBookmarks();
  Stream<MovieRow?> watchMovie(int id);
  Stream<bool> watchIsBookmarked(int id);

  // Refreshers (network → db)
  Future<bool> refreshTrending({int page = 1}); // returns endReached
  Future<bool> refreshNowPlaying({int page = 1}); // returns endReached
  Future<void> refreshMovie(int id);
  Future<void> refreshSearch(String query, {int page = 1});
  Stream<List<MovieRow>> watchSearch(String query, {int page = 1});

  // Mutations
  Future<void> toggleBookmark(int id);
  Future<void> clearBookmarks();
}
