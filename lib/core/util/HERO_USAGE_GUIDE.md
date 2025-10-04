# Hero Widget Usage Guide

This guide explains how to use the Hero utilities to prevent "multiple heroes share the same tag" errors in your Movie Verse app.

## 🚨 The Problem

The error you're seeing:
```
There are multiple heroes that share the same tag within a subtree.
In this case, multiple heroes had the following tag: poster_911430
```

This happens when:
1. The same movie appears in multiple lists/grids
2. You use the same movie ID for Hero tags
3. Multiple Hero widgets have identical tags

## ✅ The Solution

Use the provided Hero utilities that generate **truly unique tags** for each Hero widget.

## 🛠️ Available Utilities

### 1. Basic Hero Utils (`HeroUtils`)

For single, unique Hero widgets:

```dart
import 'package:movie_verse/core/constants/constants.dart';

// Create unique hero tags
Hero(
  tag: HeroUtils.posterHeroTag(movie.id),
  child: MoviePoster(movie: movie),
)

// Or use the utility method
HeroUtils.wrapWithHero(
  baseTag: 'poster',
  identifier: movie.id,
  child: MoviePoster(movie: movie),
)
```

### 2. List Hero Utils (`HeroListUtils`) - **RECOMMENDED FOR LISTS**

For Hero widgets in lists, grids, or anywhere items might appear multiple times:

```dart
// For movie posters in a list
HeroListUtils.createMoviePosterHero(
  movieId: movie.id,
  index: index, // IMPORTANT: Use the list index
  child: MoviePoster(movie: movie),
)

// For movie cards in a grid
HeroListUtils.createMovieCardHero(
  movieId: movie.id,
  index: index,
  child: MovieCard(movie: movie),
)

// For custom list items
HeroListUtils.wrapListHero(
  baseTag: 'custom_item',
  itemId: item.id,
  index: index,
  child: CustomWidget(item: item),
)
```

## 📱 Real-World Examples

### Example 1: Movie List with Hero Posters

**❌ WRONG - This will cause errors:**
```dart
ListView.builder(
  itemCount: movies.length,
  itemBuilder: (context, index) {
    final movie = movies[index];
    return Hero(
      tag: 'poster_${movie.id}', // ❌ Same tag for same movie ID
      child: MoviePoster(movie: movie),
    );
  },
)
```

**✅ CORRECT - Using HeroListUtils:**
```dart
ListView.builder(
  itemCount: movies.length,
  itemBuilder: (context, index) {
    final movie = movies[index];
    return HeroListUtils.createMoviePosterHero(
      movieId: movie.id,
      index: index, // ✅ Index makes each tag unique
      child: MoviePoster(movie: movie),
    );
  },
)
```

### Example 2: Movie Grid with Hero Cards

**❌ WRONG:**
```dart
GridView.builder(
  itemCount: movies.length,
  itemBuilder: (context, index) {
    final movie = movies[index];
    return Hero(
      tag: 'movie_${movie.id}', // ❌ Same tag for same movie
      child: MovieCard(movie: movie),
    );
  },
)
```

**✅ CORRECT:**
```dart
GridView.builder(
  itemCount: movies.length,
  itemBuilder: (context, index) {
    final movie = movies[index];
    return HeroListUtils.createMovieCardHero(
      movieId: movie.id,
      index: index, // ✅ Index makes each tag unique
      child: MovieCard(movie: movie),
    );
  },
)
```

### Example 3: Search Results with Hero

**❌ WRONG:**
```dart
ListView.builder(
  itemCount: searchResults.length,
  itemBuilder: (context, index) {
    final movie = searchResults[index];
    return Hero(
      tag: 'search_${movie.id}', // ❌ Same tag for same movie
      child: SearchResultItem(movie: movie),
    );
  },
)
```

**✅ CORRECT:**
```dart
ListView.builder(
  itemCount: searchResults.length,
  itemBuilder: (context, index) {
    final movie = searchResults[index];
    return HeroListUtils.createSearchResultHero(
      itemId: movie.id,
      index: index, // ✅ Index makes each tag unique
      searchQuery: currentQuery,
      child: SearchResultItem(movie: movie),
    );
  },
)
```

## 🔧 Migration Steps

### Step 1: Find All Hero Widgets
Search your codebase for:
- `Hero(` 
- `tag: 'poster_`
- `tag: 'movie_`
- `tag: 'backdrop_`

### Step 2: Replace with Utilities
Replace each Hero widget with the appropriate utility:

```dart
// Before
Hero(
  tag: 'poster_${movie.id}',
  child: widget,
)

// After
HeroListUtils.createMoviePosterHero(
  movieId: movie.id,
  index: index, // Add index parameter
  child: widget,
)
```

### Step 3: Add Index Parameters
Make sure you have access to the index in your builders:

```dart
// If you don't have index, add it:
itemBuilder: (context, index) {
  // Now you have access to index
}
```

## 📋 Best Practices

1. **Always use index-based tags for lists/grids**
2. **Use `HeroListUtils` for any item that might appear multiple times**
3. **Use `HeroUtils` only for truly unique, single instances**
4. **Never hardcode Hero tags**
5. **Test with duplicate data to ensure uniqueness**

## 🧪 Testing

To verify your fix works:

1. Add the same movie to multiple lists
2. Navigate between different screens
3. Check that no Hero tag errors occur
4. Verify Hero animations work correctly

## 🚀 Performance Notes

- The utilities generate tags at build time, no runtime overhead
- Index-based tags are lightweight and efficient
- Context-based tags use minimal memory for hash codes

## 🔍 Debugging

If you still get errors:

1. Check that you're using the correct utility for your use case
2. Verify that `index` is unique for each item
3. Ensure you're not mixing different Hero utilities for the same item
4. Use `HeroUtils.resetCounter()` if needed for testing

## 📚 Complete Example

Here's a complete working example:

```dart
class MovieListScreen extends StatelessWidget {
  final List<Movie> movies;

  const MovieListScreen({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.home)),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return HeroListUtils.createMoviePosterHero(
            movieId: movie.id,
            index: index,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              ),
              child: MoviePoster(movie: movie),
            ),
          );
        },
      ),
    );
  }
}
```

This approach ensures that each Hero widget gets a unique tag, preventing the "multiple heroes share the same tag" error.
