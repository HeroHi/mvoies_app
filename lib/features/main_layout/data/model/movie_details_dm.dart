
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/networking/api_constants.dart';

import '../../domain/entities/movie_details_entity.dart';
import 'genre_response.dart';

part 'movie_details_dm.g.dart';

@JsonSerializable()
class MovieDetailsDM {
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final dynamic belongsToCollection; // Can be replaced with a specific model if needed
  final int? budget;
  final List<Genre> genres;
  final String? homepage;
  final int? id;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  final List<ProductionCompanyDM>? productionCompanies;
  final List<ProductionCountryDM>? productionCountries;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageDM>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

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
  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id!,
      title: title!,
      overview: overview!,
      posterPath:ApiConstants.imagesBaseUrl+ (posterPath ?? ""),
      releaseDate: releaseDate!,
      popularity: voteCount!,
      voteAverage: voteAverage!,
      genres: genres,
    );
  }
}



@JsonSerializable()
class ProductionCompanyDM {
  final int id;
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  ProductionCompanyDM({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyDM.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyDMFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyDMToJson(this);
}

@JsonSerializable()
class ProductionCountryDM {
  @JsonKey(name: 'iso_3166_1')
  final String isoCode;
  final String name;

  ProductionCountryDM({required this.isoCode, required this.name});

  factory ProductionCountryDM.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryDMFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryDMToJson(this);
}

@JsonSerializable()
class SpokenLanguageDM {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String isoCode;
  final String name;

  SpokenLanguageDM({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });

  factory SpokenLanguageDM.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageDMFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageDMToJson(this);
}

