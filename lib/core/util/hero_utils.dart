import 'package:flutter/material.dart';

/// Utility class to help manage Hero widgets and prevent duplicate tag errors
class HeroUtils {
  HeroUtils._();

  // Static counter to ensure unique tags across the app
  static int _counter = 0;

  /// Creates a truly unique hero tag by appending a unique counter
  /// This prevents "multiple heroes share the same tag" errors
  static String createUniqueTag(String baseTag, {String? identifier}) {
    _counter++;
    if (identifier != null) {
      return '${baseTag}_${identifier}_$_counter';
    }
    return '${baseTag}_${DateTime.now().millisecondsSinceEpoch}_$_counter';
  }

  /// Creates a unique hero tag for movie items
  static String movieHeroTag(String movieId) {
    _counter++;
    return 'movie_${movieId}_$_counter';
  }

  /// Creates a unique hero tag for poster images
  static String posterHeroTag(String movieId) {
    _counter++;
    return 'poster_${movieId}_$_counter';
  }

  /// Creates a unique hero tag for backdrop images
  static String backdropHeroTag(String movieId) {
    _counter++;
    return 'backdrop_${movieId}_$_counter';
  }

  /// Creates a unique hero tag for profile images
  static String profileHeroTag(String personId) {
    _counter++;
    return 'profile_${personId}_$_counter';
  }

  /// Creates a unique hero tag for any widget with context
  static String createContextualTag(String baseTag, String identifier, BuildContext context) {
    _counter++;
    // Use the widget's hash code to make it even more unique
    return '${baseTag}_${identifier}_${context.hashCode}_$_counter';
  }

  /// Wraps a widget with Hero using a unique tag
  static Widget wrapWithHero({
    required Widget child,
    required String baseTag,
    String? identifier,
  }) {
    return Hero(
      tag: createUniqueTag(baseTag, identifier: identifier),
      child: child,
    );
  }

  /// Creates a hero with automatic tag generation
  static Widget createHero({
    required Widget child,
    required String baseTag,
    String? identifier,
  }) {
    return Hero(
      tag: createUniqueTag(baseTag, identifier: identifier),
      child: child,
    );
  }

  /// Creates a hero with contextual uniqueness (recommended for lists)
  static Widget createContextualHero({
    required Widget child,
    required String baseTag,
    required String identifier,
    required BuildContext context,
  }) {
    return Hero(
      tag: createContextualTag(baseTag, identifier, context),
      child: child,
    );
  }

  /// Resets the counter (useful for testing or if you need to restart)
  static void resetCounter() {
    _counter = 0;
  }
}
