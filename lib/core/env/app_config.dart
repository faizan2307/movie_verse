class AppConfig {

  /// we can also store it in evn variables and fire the project using:
  /// fvm flutter run --dart-define=TMDB_API_KEY=6f0044ecdbe0e67fafb69ab0d2e0c2fa
  ///
  // static const tmdbApiKey = String.fromEnvironment('TMDB_API_KEY');


  static const tmdbApiKey = "36af65460e509af3f9f6c25ebefe264f";
  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const imageBase = 'https://image.tmdb.org/t/p/';
}