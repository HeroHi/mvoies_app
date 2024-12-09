import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/movie_entity.dart';
import 'genre_response.dart';

part 'movie_details_dm.g.dart';

@JsonSerializable()
class MovieDetailsDM {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final dynamic belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final List<dynamic> productionCompanies;
  final List<dynamic> productionCountries;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: 'spoken_languages')
  final List<dynamic> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  MovieDetailsDM({
    required this.adult,
    this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsDM.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDMFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsDMToJson(this);

  /// Converts the data model to a domain entity with required fields.
  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath ?? "",
      releaseDate: releaseDate,
      popularity: popularity,
      voteAverage: voteAverage,
      genres: genres,
    );
  }
}
