import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import '../../data/router/app_router.dart';
import '../constants/app_strings.dart';
import '../navigation/app_navigator.dart';

/// Handles deep links for the Movie Verse app.
/// 
/// This class manages both cold start deep links (when the app is launched from a link)
/// and foreground deep links (when the app is already running).
/// 
/// Deep links follow the format: `visionmovies://movie/{movieId}`
/// 
/// Example usage:
/// ```dart
/// final deepLinkHandler = DeepLinkHandler(router);
/// await deepLinkHandler.init();
/// ```
class DeepLinkHandler {
  /// Creates a new DeepLinkHandler instance.
  /// 
  /// [router] - The GoRouter instance used for navigation within the app.
  DeepLinkHandler();

  // DeepLinkHandler(this._router);

  /// The GoRouter instance for handling navigation.
  // final AppNavigator _router;
  
  /// Stream subscription for listening to incoming deep links while the app is running.
  StreamSubscription<Uri>? _sub;

  /// Initializes the deep link handler.
  /// 
  /// This method sets up both cold start and foreground deep link handling:
  /// - Cold start: Handles the link that launched the app (if any)
  /// - Foreground: Listens for incoming deep links while the app is running
  /// 
  /// Should be called before `runApp()` to ensure cold start links are handled.
  Future<void> init() async {
    final appLinks = AppLinks();

    // Handle cold start deep links (the link that launched the app)
    try {
      final initial = await appLinks.getInitialLink();
      if (initial != null) _handle(initial);
    } catch (_) {
      // Silently handle any errors during cold start link retrieval
      // This prevents app crashes if there are issues with the deep link
    }

    // Listen for foreground deep links while the app is running
    _sub = appLinks.uriLinkStream.listen(_handle, onError: (_) {
      // Silently handle any errors during foreground link processing
      // This prevents app crashes if there are issues with incoming links
    });
  }

  void handle(Uri uri) => _handle(uri);

  /// Handles incoming deep link URIs.
  /// 
  /// This method parses the URI and navigates to the appropriate content.
  /// It supports multiple URI formats for flexibility:
  /// - `visionmovies://movie/123` (standard format)
  /// - `visionmovies://movie/123/anything` (with additional path segments)
  /// 
  /// [uri] - The incoming deep link URI to process.
  void _handle(Uri uri) {
    // Validate the URI scheme (must be 'visionmovies')
    final isSchemeOk = uri.scheme == AppStrings.deepLinkScheme;
    
    // Check if this is a movie-related deep link
    // Accepts both host-based and path-based movie identifiers
    final isMovie = uri.host == AppStrings.deepLinkHost || 
                   (uri.pathSegments.isNotEmpty && uri.pathSegments.first == AppStrings.deepLinkHost);
    
    // Extract the movie ID from the URI
    // This handles both formats: host-based and path-based
    final idStr = (() {
      // Format: visionmovies://movie/123
      if (uri.host == AppStrings.deepLinkHost && uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.first;
      }
      // Format: visionmovies://movie/123/anything
      if (uri.pathSegments.length >= 2 && uri.pathSegments.first == AppStrings.deepLinkHost) {
        return uri.pathSegments[1];
      }
      return null;
    })();

    // Process the deep link if all validations pass
    if (isSchemeOk && isMovie && idStr != null) {
      final id = int.tryParse(idStr);
      if (id != null) {
        // Navigate to the movie details page using GoRouter
        router.push('/movie/$id');
      }
      // If parsing fails, silently ignore the invalid ID
    }
    // If any validation fails, silently ignore the invalid deep link
  }

  /// Disposes of the deep link handler.
  /// 
  /// This method cancels the stream subscription to prevent memory leaks.
  /// Should be called when the app is shutting down or the handler is no longer needed.
  Future<void> dispose() async => _sub?.cancel();
}
