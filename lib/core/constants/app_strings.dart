/// App string constants for consistent text across the application
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // App Information
  static const String appName = 'Movie Verse';
  static const String appDescription = 'A movie player app';
  static const String appVersion = '1.0.0';
  
  // Navigation Labels
  static const String home = 'Home';
  static const String search = 'Search';
  static const String saved = 'Saved';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  
  // Common Actions
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String remove = 'Remove';
  static const String confirm = 'Confirm';
  static const String close = 'Close';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String submit = 'Submit';
  static const String retry = 'Retry';
  static const String refresh = 'Refresh';
  static const String share = 'Share';
  static const String download = 'Download';
  static const String play = 'Play';
  static const String pause = 'Pause';
  static const String stop = 'Stop';
  
  // Search
  static const String searchHint = 'Search movies...';
  static const String searchResults = 'Search Results';
  static const String noSearchResults = 'No movies found';
  static const String searchHistory = 'Search History';
  static const String clearSearch = 'Clear Search';
  
  // Movie Details
  static const String movieDetails = 'Movie Details';
  static const String cast = 'Cast';
  static const String crew = 'Crew';
  static const String director = 'Director';
  static const String producer = 'Producer';
  static const String writer = 'Writer';
  static const String genre = 'Genre';
  static const String genres = 'Genres';
  static const String releaseDate = 'Release Date';
  static const String runtime = 'Runtime';
  static const String rating = 'Rating';
  static const String overview = 'Overview';
  static const String synopsis = 'Synopsis';
  static const String trailer = 'Trailer';
  static const String trailers = 'Trailers';
  static const String reviews = 'Reviews';
  static const String userReviews = 'User Reviews';
  static const String criticReviews = 'Critic Reviews';
  static const String similarMovies = 'Similar Movies';
  static const String recommendations = 'Recommendations';
  
  // Ratings and Reviews
  static const String rateThisMovie = 'Rate this movie';
  static const String writeReview = 'Write a review';
  static const String reviewHint = 'Share your thoughts about this movie...';
  static const String submitReview = 'Submit Review';
  static const String reviewSubmitted = 'Review submitted successfully';
  static const String reviewError = 'Failed to submit review';
  
  // Favorites and Watchlist
  static const String addToFavorites = 'Add to Favorites';
  static const String removeFromFavorites = 'Remove from Favorites';
  static const String addToWatchlist = 'Add to Watchlist';
  static const String removeFromWatchlist = 'Remove from Watchlist';
  static const String inFavorites = 'In Favorites';
  static const String inWatchlist = 'In Watchlist';
  static const String favorites = 'Favorites';
  static const String watchlist = 'Watchlist';
  
  // Categories
  static const String trending = 'Trending';
  static const String popular = 'Popular';
  static const String topRated = 'Top Rated';
  static const String upcoming = 'Upcoming';
  static const String nowPlaying = 'Now Playing';
  static const String latest = 'Latest';
  static const String featured = 'Featured';
  static const String newReleases = 'New Releases';
  
  // Genres
  static const String action = 'Action';
  static const String adventure = 'Adventure';
  static const String animation = 'Animation';
  static const String comedy = 'Comedy';
  static const String crime = 'Crime';
  static const String documentary = 'Documentary';
  static const String drama = 'Drama';
  static const String family = 'Family';
  static const String fantasy = 'Fantasy';
  static const String horror = 'Horror';
  static const String mystery = 'Mystery';
  static const String romance = 'Romance';
  static const String sciFi = 'Science Fiction';
  static const String thriller = 'Thriller';
  static const String war = 'War';
  static const String western = 'Western';
  
  // Error Messages
  static const String errorOccurred = 'An error occurred';
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'Unknown error occurred';
  static const String noInternetConnection = 'No internet connection';
  static const String connectionTimeout = 'Connection timeout';
  static const String dataNotFound = 'Data not found';
  static const String permissionDenied = 'Permission denied';
  static const String invalidInput = 'Invalid input';
  static const String tryAgain = 'Please try again';
  
  // Success Messages
  static const String success = 'Success';
  static const String operationCompleted = 'Operation completed successfully';
  static const String dataSaved = 'Data saved successfully';
  static const String dataDeleted = 'Data deleted successfully';
  static const String dataUpdated = 'Data updated successfully';
  
  // Loading and Empty States
  static const String loading = 'Loading...';
  static const String pleaseWait = 'Please wait...';
  static const String noData = 'No data available';
  static const String noMovies = 'No movies available';
  static const String noFavorites = 'No favorite movies yet';
  static const String noWatchlist = 'No movies in watchlist';
  static const String noSearchHistory = 'No search history';
  static const String noReviews = 'No reviews yet';
  
  // Settings
  static const String generalSettings = 'General Settings';
  static const String appearance = 'Appearance';
  static const String notifications = 'Notifications';
  static const String privacy = 'Privacy';
  static const String about = 'About';
  static const String help = 'Help';
  static const String feedback = 'Feedback';
  static const String rateApp = 'Rate App';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  
  // Time and Duration
  static const String minutes = 'min';
  static const String hours = 'hr';
  static const String days = 'days';
  static const String ago = 'ago';
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String thisWeek = 'This Week';
  static const String thisMonth = 'This Month';
  static const String thisYear = 'This Year';
  
  // Formatting
  static const String ratingFormat = '{rating}/10';
  static const String durationFormat = '{hours}h {minutes}m';
  static const String releaseDateFormat = 'MMM dd, yyyy';
  static const String searchResultFormat = '{count} results found';
  
  // Sharing and Deep Links
  static const String shareMovieMessage = 'Hey!! I found this cool movie on Movie Verse.\nQuickly watch here: {deepLink}';
  static const String shareMovieTitle = 'Share Movie';
  static const String shareMovieSubject = 'Check out this movie on Movie Verse!';
  static const String deepLinkScheme = 'visionmovies';
  static const String deepLinkHost = 'movie';
  static const String deepLinkFormat = '{scheme}://{host}/{id}';
  static const String notFound = 'Not found';
  static const String details = 'Details';
  
  // Deep Link Handler
  static const String deepLinkTester = 'Deep Link Tester';
  static const String enterDeepLink = 'Enter Deep Link';
  static const String validate = 'Validate';
  static const String navigate = 'Navigate';
  static const String generateSampleLink = 'Generate Sample Link';
  static const String deepLinkFormatLabel = 'Deep Link Format:';
  static const String example = 'Example:';
  static const String pleaseEnterDeepLink = 'Please enter a deep link';
  static const String validDeepLink = '✅ Valid deep link! Movie ID: {id}';
  static const String invalidDeepLink = '❌ Invalid deep link format';
  
  // Settings Page
  static const String appInformation = 'App Information';
  static const String deepLinkInformation = 'Deep Link Information';
  static const String howToUseDeepLinks = 'How to Use Deep Links';
  static const String deepLinkDescription = 'You can share movies with friends using deep links. When they tap the link, it will open the app and take them directly to the movie.';
  static const String step1 = 'Go to any movie details page';
  static const String step2 = 'Tap the Share button';
  static const String step3 = 'Choose your sharing method (WhatsApp, SMS, etc.)';
  static const String step4 = 'Your friend receives a link like: {scheme}://{host}/123';
  static const String step5 = 'When they tap the link, it opens Movie Verse and shows the movie';
}
