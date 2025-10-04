import 'package:mockito/annotations.dart';

// Subjects to mock
import 'package:movie_verse/core/navigation/app_navigator.dart';
import 'package:movie_verse/core/network/tmdb_api.dart';
import 'package:movie_verse/core/db/drift_db.dart';
import 'package:movie_verse/domain/repositories/movie_repository.dart';

@GenerateMocks([
  AppNavigator,
  TmdbApi,
  AppDatabase,
  MovieRepository,
])
void main() {}