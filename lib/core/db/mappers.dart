import 'package:drift/drift.dart';
import '../network/models/dto_movie.dart';
import '../network/models/dto_movie_details.dart';
import 'drift_db.dart';

MoviesCompanion movieDtoToCompanion(MovieDto m) => MoviesCompanion(
  id: Value(m.id),
  title: Value(m.displayTitle),
  overview: Value(m.overview),
  posterPath: Value(m.posterPath),
  backdropPath: Value(m.backdropPath),
  voteAverage: Value(m.voteAverage),
  releaseDate: Value(m.releaseDate),
  runtime: const Value.absent(),
  genresCsv: const Value.absent(),
);

MoviesCompanion movieDetailsToCompanion(MovieDetailsDto m) => MoviesCompanion(
  id: Value(m.id),
  title: Value(m.displayTitle),
  overview: Value(m.overview),
  posterPath: Value(m.posterPath),
  backdropPath: Value(m.backdropPath),
  voteAverage: Value(m.voteAverage),
  releaseDate: Value(m.releaseDate),
  runtime: Value(m.runtime),
  genresCsv: Value(_genresToCsv(m.genres)),
);

String? _genresToCsv(List<Map<String, dynamic>>? genres) {
  if (genres == null || genres.isEmpty) return null;
  final names = genres.map((g) => (g['name'] ?? '').toString()).where((s) => s.isNotEmpty).toList();
  if (names.isEmpty) return null;
  return names.join(',');
}
