/// Barrel file that exports all constants and utilities for easy importing.
/// 
/// This file provides a single import point for:
/// - App colors and themes
/// - String constants
/// - Hero animation utilities
/// - Deep link utilities
/// 
/// Usage:
/// ```dart
/// import 'package:movie_verse/core/constants/constants.dart';
/// ```
export 'app_colors.dart';
export 'app_strings.dart';
export 'app_theme.dart';

// Hero animation utilities for smooth transitions
export '../util/hero_utils.dart';
export '../util/hero_list_utils.dart';

// Deep link utilities for sharing and navigation
export '../util/deep_link_utils.dart';
