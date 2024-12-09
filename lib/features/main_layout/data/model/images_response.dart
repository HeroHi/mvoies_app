import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/networking/api_constants.dart';

import '../../domain/entities/backdrop_entity.dart';

part 'images_response.g.dart';

@JsonSerializable()
class Backdrop {
  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'file_path')
  final String? filePath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @JsonKey(name: 'width')
  final int? width;

  Backdrop({
    this.aspectRatio,
    this.height,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Backdrop.fromJson(Map<String, dynamic> json) => _$BackdropFromJson(json);

  Map<String, dynamic> toJson() => _$BackdropToJson(this);
  BackdropEntity toEntity() {
    return BackdropEntity(
      aspectRatio: aspectRatio,
      filePath: ApiConstants.imagesBaseUrl+(filePath??""),
    );
  }
}

@JsonSerializable()
class Poster {
  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;

  @JsonKey(name: 'height')
  final int? height;

  @JsonKey(name: 'file_path')
  final String? filePath;

  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @JsonKey(name: 'width')
  final int? width;

  Poster({
    this.aspectRatio,
    this.height,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);

  Map<String, dynamic> toJson() => _$PosterToJson(this);
}

@JsonSerializable()
class Images {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'backdrops')
  final List<Backdrop>? backdrops;

  @JsonKey(name: 'posters')
  final List<Poster>? posters;

  @JsonKey(name: 'logos')
  final List<dynamic>? logos;

  Images({
    this.id,
    this.backdrops,
    this.posters,
    this.logos,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
