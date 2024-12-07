import 'package:json_annotation/json_annotation.dart';

part 'genre_response.g.dart';


@JsonSerializable()
class GenresResponse {
  final List<Genre> genres;

  GenresResponse({required this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) =>
      _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);
}


@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
