import 'package:json_annotation/json_annotation.dart';
import 'dto_movie.dart';
part 'dto_movie_details.g.dart';

@JsonSerializable()
class MovieDetailsDto extends MovieDto {
  final int? runtime;
  final List<Map<String, dynamic>>? genres;

  MovieDetailsDto({
    required super.id,
    super.title,
    super.name,
    super.overview,
    super.posterPath,
    super.backdropPath,
    super.voteAverage,
    super.releaseDate,
    this.runtime,
    this.genres,
  });

  factory MovieDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDtoFromJson(json);
}
