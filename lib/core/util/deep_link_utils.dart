import '../constants/app_strings.dart';

/// Utility class for working with deep links in the Movie Verse app.
/// 
/// This class provides helper methods for creating, validating, and parsing deep links.
/// It works in conjunction with the `DeepLinkHandler` class to provide a complete
/// deep linking solution.
/// 
/// Deep links follow the format: `visionmovies://movie/{movieId}`
/// 
/// Example usage:
/// ```dart
/// // Create a deep link for sharing
/// final deepLink = DeepLinkUtils.createMovieDeepLink(123);
/// 
/// // Create a shareable message
/// final message = DeepLinkUtils.createShareMessage(123);
/// 
/// // Validate a deep link
/// final isValid = DeepLinkUtils.isValidDeepLink('visionmovies://movie/123');
/// ```
class DeepLinkUtils {
  /// Private constructor to prevent instantiation.
  /// This class only contains static utility methods.
  DeepLinkUtils._();

  /// Creates a deep link for a specific movie.
  /// 
  /// This method generates a properly formatted deep link that can be used
  /// for sharing movies or external navigation.
  /// 
  /// [movieId] - The unique identifier of the movie.
  /// 
  /// Returns a deep link string in the format: `visionmovies://movie/{movieId}`
  /// 
  /// Example:
  /// ```dart
  /// final deepLink = DeepLinkUtils.createMovieDeepLink(123);
  /// // Returns: "visionmovies://movie/123"
  /// ```
  static String createMovieDeepLink(int movieId) {
    return '${AppStrings.deepLinkScheme}://${AppStrings.deepLinkHost}/$movieId';
  }

  /// Creates a shareable message for a movie with an embedded deep link.
  /// 
  /// This method generates a user-friendly message that includes the deep link,
  /// making it easy for users to share movies with friends.
  /// 
  /// [movieId] - The unique identifier of the movie.
  /// 
  /// Returns a formatted share message with the deep link embedded.
  /// 
  /// Example:
  /// ```dart
  /// final message = DeepLinkUtils.createShareMessage(123);
  /// // Returns: "Hey!! I found this cool movie on Movie Verse.\nQuickly watch here: visionmovies://movie/123"
  /// ```
  static String createShareMessage(int movieId) {
    final deepLink = createMovieDeepLink(movieId);
    return AppStrings.shareMovieMessage.replaceAll('{deepLink}', deepLink);
  }

  /// Validates if a string is a valid deep link.
  /// 
  /// This method checks if the provided string follows the correct deep link format:
  /// - Has the correct scheme (`visionmovies`)
  /// - Has the correct host (`movie`)
  /// - Contains at least one path segment (the movie ID)
  /// 
  /// [link] - The string to validate as a deep link.
  /// 
  /// Returns `true` if the link is valid, `false` otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final isValid = DeepLinkUtils.isValidDeepLink('visionmovies://movie/123');
  /// // Returns: true
  /// 
  /// final isInvalid = DeepLinkUtils.isValidDeepLink('invalid://link');
  /// // Returns: false
  /// ```
  static bool isValidDeepLink(String link) {
    try {
      final uri = Uri.parse(link);
      return uri.scheme == AppStrings.deepLinkScheme && 
             uri.host == AppStrings.deepLinkHost &&
             uri.pathSegments.isNotEmpty;
    } catch (e) {
      // Return false for any parsing errors or invalid URI formats
      return false;
    }
  }

  /// Parses a deep link and extracts the movie ID.
  /// 
  /// This method attempts to extract the movie ID from a valid deep link.
  /// It first validates the link format, then extracts and parses the movie ID.
  /// 
  /// [deepLink] - The deep link string to parse.
  /// 
  /// Returns the movie ID as an integer if successful, `null` if the link is invalid
  /// or if the movie ID cannot be parsed.
  /// 
  /// Example:
  /// ```dart
  /// final movieId = DeepLinkUtils.parseMovieDeepLink('visionmovies://movie/123');
  /// // Returns: 123
  /// 
  /// final invalidId = DeepLinkUtils.parseMovieDeepLink('invalid://link');
  /// // Returns: null
  /// ```
  static int? parseMovieDeepLink(String deepLink) {
    try {
      final uri = Uri.parse(deepLink);
      // Validate the deep link format
      if (uri.scheme == AppStrings.deepLinkScheme && 
          uri.host == AppStrings.deepLinkHost) {
        final pathSegments = uri.pathSegments;
        if (pathSegments.isNotEmpty) {
          // Attempt to parse the movie ID from the first path segment
          return int.tryParse(pathSegments.first);
        }
      }
    } catch (e) {
      // Return null for any parsing errors or invalid URI formats
    }
    return null;
  }
}
