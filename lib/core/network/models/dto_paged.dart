import 'package:json_annotation/json_annotation.dart';
part 'dto_paged.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagedResponse<T> {
  final int page;
  @JsonKey(name: 'total_pages') final int totalPages;
  @JsonKey(name: 'total_results') final int totalResults;
  final List<T> results;

  PagedResponse({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.results,
  });

  factory PagedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) => _$PagedResponseFromJson(json, fromJsonT);
}
