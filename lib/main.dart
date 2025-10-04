import 'package:flutter/material.dart';
import 'core/deep_link/deep_link_handler.dart';
import 'core/di/injection.dart';
import 'app.dart';

/// Global deep link handler instance.
/// 
/// This handler is initialized before the app starts to ensure that
/// any deep links that launched the app are properly processed.
late final DeepLinkHandler _dl;

/// Main entry point of the Movie Verse application.
/// 
/// This function:
/// 1. Initializes Flutter bindings
/// 2. Configures dependency injection
/// 3. Sets up deep link handling for cold start links
/// 4. Launches the main app
Future<void> main() async {
  // Ensure Flutter is properly initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure dependency injection for the app
  await configureDependencies();

  // Initialize deep link handler BEFORE runApp to ensure cold start links are processed
  // This is crucial for handling deep links that launched the app
  // _dl = DeepLinkHandler(GoRouterNavigator());
  _dl = DeepLinkHandler();
  await _dl.init();

  // Launch the main application
  runApp(const MyApp());
}