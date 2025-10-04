import 'package:json_annotation/json_annotation.dart';
part 'dto_movie.g.dart';

@JsonSerializable()
class MovieDto {
  final int id;
  final String? title;
  final String? name;
  final String? overview;
  @JsonKey(name: 'poster_path') final String? posterPath;
  @JsonKey(name: 'backdrop_path') final String? backdropPath;
  @JsonKey(name: 'vote_average') final double? voteAverage;
  @JsonKey(name: 'release_date') final String? releaseDate;

  MovieDto({
    required this.id,
    this.title,
    this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.releaseDate,
  });

  String get displayTitle => title ?? name ?? '';

  factory MovieDto.fromJson(Map<String, dynamic> json) => _$MovieDtoFromJson(json);
}
