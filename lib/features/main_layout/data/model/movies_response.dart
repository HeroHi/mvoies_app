import 'package:json_annotation/json_annotation.dart';

import 'movie_dm.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  final int page;
  final List<MovieDM> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);
}