# App Constants and Theme System

This directory contains the centralized constants and theme configuration for the Movie Verse app.

## Files

### `app_colors.dart`
Contains all color constants used throughout the application:
- Primary, secondary, and accent colors
- Text colors for different states
- Background and surface colors
- Status colors (success, warning, error, info)
- Movie-specific colors
- Navigation colors
- Predefined gradients

### `app_strings.dart`
Contains all string constants for consistent text across the app:
- App information
- Navigation labels
- Common actions
- Search-related strings
- Movie details and categories
- Error and success messages
- Loading and empty states
- Settings and help text

### `app_theme.dart`
Provides comprehensive theme configuration:
- Light theme with Material 3 design
- Dark theme support
- Consistent styling for all UI components
- Typography, colors, and component themes

### `constants.dart`
Barrel file that exports all constants for easy importing.

## Usage

### Importing Constants

```dart
import 'package:movie_verse/core/constants/constants.dart';

// Use colors
Container(
  color: AppColors.primary,
  child: Text(
    'Hello World',
    style: TextStyle(color: AppColors.textPrimary),
  ),
)

// Use strings
AppBar(
  title: Text(AppStrings.home),
)

// Use theme
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
)
```

### Using Colors

```dart
// Primary colors
AppColors.primary
AppColors.primaryLight
AppColors.primaryDark

// Text colors
AppColors.textPrimary
AppColors.textSecondary
AppColors.textHint

// Status colors
AppColors.success
AppColors.error
AppColors.warning
AppColors.info

// Gradients
AppColors.primaryGradient
AppColors.secondaryGradient
AppColors.accentGradient
```

### Using Strings

```dart
// Navigation
AppStrings.home
AppStrings.search
AppStrings.saved

// Actions
AppStrings.save
AppStrings.cancel
AppStrings.delete

// Movie details
AppStrings.movieDetails
AppStrings.cast
AppStrings.genres
AppStrings.releaseDate
```

### Using Theme

```dart
// In MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
)

// Access theme in widgets
Theme.of(context).colorScheme.primary
Theme.of(context).textTheme.headlineLarge
Theme.of(context).cardTheme
```

## Best Practices

1. **Always use constants**: Never hardcode colors or strings in your widgets
2. **Consistent naming**: Follow the established naming conventions
3. **Theme-aware**: Use theme colors instead of hardcoded colors when possible
4. **Import efficiently**: Use the barrel file import for multiple constants
5. **Extend carefully**: Add new constants following the existing pattern

## Adding New Constants

### Adding Colors
```dart
// In app_colors.dart
static const Color newColor = Color(0xFF123456);
```

### Adding Strings
```dart
// In app_strings.dart
static const String newString = 'New String Value';
```

### Adding Theme Properties
```dart
// In app_theme.dart
// Add to the appropriate theme section
```

## Hero Widget Usage

To prevent "multiple heroes share the same tag" errors, use the `HeroUtils` class:

```dart
import 'package:movie_verse/core/util/hero_utils.dart';

// Create unique hero tags
Hero(
  tag: HeroUtils.movieHeroTag(movie.id),
  child: MoviePoster(movie: movie),
)

// Or use the utility method
HeroUtils.wrapWithHero(
  baseTag: 'movie',
  identifier: movie.id,
  child: MoviePoster(movie: movie),
)
```

## Benefits

- **Consistency**: Ensures consistent colors and text across the app
- **Maintainability**: Easy to update colors and strings in one place
- **Theme Support**: Built-in light/dark theme support
- **Type Safety**: Compile-time checking for constants
- **Performance**: Constants are compiled into the app, no runtime overhead
- **Scalability**: Easy to add new constants and themes
