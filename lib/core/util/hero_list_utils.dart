import 'package:flutter/material.dart';

/// Specialized utility for handling Hero widgets in lists and grids
/// This prevents duplicate hero tag errors when the same item appears multiple times
class HeroListUtils {
  HeroListUtils._();

  /// Creates a unique hero tag for list items using index and item ID
  /// This ensures each item in a list gets a unique hero tag
  static String createListHeroTag(String baseTag, String itemId, int index) {
    return '${baseTag}_${itemId}_index_$index';
  }

  /// Creates a unique hero tag for grid items using row, column, and item ID
  /// This ensures each item in a grid gets a unique hero tag
  static String createGridHeroTag(String baseTag, String itemId, int row, int column) {
    return '${baseTag}_${itemId}_${row}_$column';
  }

  /// Creates a unique hero tag for list items with additional context
  static String createContextualListTag(String baseTag, String itemId, int index, BuildContext context) {
    return '${baseTag}_${itemId}_${index}_${context.hashCode}';
  }

  /// Wraps a list item with Hero using index-based uniqueness
  static Widget wrapListHero({
    required Widget child,
    required String baseTag,
    required String itemId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag(baseTag, itemId, index),
      child: child,
    );
  }

  /// Wraps a grid item with Hero using position-based uniqueness
  static Widget wrapGridHero({
    required Widget child,
    required String baseTag,
    required String itemId,
    required int row,
    required int column,
  }) {
    return Hero(
      tag: createGridHeroTag(baseTag, itemId, row, column),
      child: child,
    );
  }

  /// Creates a hero for movie posters in a list
  static Widget createMoviePosterHero({
    required Widget child,
    required String movieId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('poster', movieId, index),
      child: child,
    );
  }

  /// Creates a hero for movie backdrops in a list
  static Widget createMovieBackdropHero({
    required Widget child,
    required String movieId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('backdrop', movieId, index),
      child: child,
    );
  }

  /// Creates a hero for movie cards in a list
  static Widget createMovieCardHero({
    required Widget child,
    required String movieId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('movie_card', movieId, index),
      child: child,
    );
  }

  /// Creates a hero for cast/crew items in a list
  static Widget createCastHero({
    required Widget child,
    required String personId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('cast', personId, index),
      child: child,
    );
  }

  /// Creates a hero for genre chips in a list
  static Widget createGenreHero({
    required Widget child,
    required String genreName,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('genre', genreName, index),
      child: child,
    );
  }

  /// Creates a hero for search result items
  static Widget createSearchResultHero({
    required Widget child,
    required String itemId,
    required int index,
    required String searchQuery,
  }) {
    return Hero(
      tag: 'search_${searchQuery}_${itemId}_$index',
      child: child,
    );
  }

  /// Creates a hero for category items
  static Widget createCategoryHero({
    required Widget child,
    required String categoryName,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('category', categoryName, index),
      child: child,
    );
  }

  /// Creates a hero for navigation items
  static Widget createNavigationHero({
    required Widget child,
    required String routeName,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('nav', routeName, index),
      child: child,
    );
  }

  /// Creates a hero for settings items
  static Widget createSettingsHero({
    required Widget child,
    required String settingKey,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag('setting', settingKey, index),
      child: child,
    );
  }

  /// Creates a hero for any list item with custom base tag
  static Widget createCustomListHero({
    required Widget child,
    required String baseTag,
    required String itemId,
    required int index,
  }) {
    return Hero(
      tag: createListHeroTag(baseTag, itemId, index),
      child: child,
    );
  }

  /// Creates a hero for any grid item with custom base tag
  static Widget createCustomGridHero({
    required Widget child,
    required String baseTag,
    required String itemId,
    required int row,
    required int column,
  }) {
    return Hero(
      tag: createGridHeroTag(baseTag, itemId, row, column),
      child: child,
    );
  }
}
