

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/networking/api_error_model.dart';
part 'details_state.freezed.dart';
@freezed
class DetailsState<T> with _$DetailsState<T>{
  const factory DetailsState.initial() = Initial;

  //Movie
  const factory DetailsState.movieLoading() = MovieLoading;
  const factory DetailsState.movieSuccess(T data) = MovieSuccess<T>;
  const factory DetailsState.movieFailure(ApiErrorModel error) = MovieFailure;

  //Genres
  const factory DetailsState.imagesLoading() = ImagesLoading;
  const factory DetailsState.imagesSuccess(T data) = ImagesSuccess<T>;
  const factory DetailsState.imagesFailure(ApiErrorModel error) = ImagesFailure;

  //Similar Movies
  const factory DetailsState.similarLoading() = SimilarLoading;
  const factory DetailsState.similarSuccess(T data) = SimilarSuccess<T>;
  const factory DetailsState.similarFailure(ApiErrorModel error) = SimilarFailure;

  //Cast
  const factory DetailsState.castLoading() = CastLoading;
  const factory DetailsState.castSuccess(T data) = CastSuccess<T>;
  const factory DetailsState.castFailure(ApiErrorModel error) = CastFailure;

  //Save Movie
  const factory DetailsState.saveMovieLoading() = SaveMovieLoading;
  const factory DetailsState.saveMovieSuccess() = SaveMovieSuccess<T>;
  const factory DetailsState.saveMovieFailure(String errorMsg) = SaveMovieFailure;
}
extension DetailsStateExtensions<T> on DetailsState<T> {
  /// Checks if the current state is related to cast operations
  bool get isCastState =>
      this is CastLoading || this is CastSuccess<T> || this is CastFailure;

  /// Checks if the current state is related to similar movie operations
  bool get isSimilarState =>
      this is SimilarLoading || this is SimilarSuccess<T> || this is SimilarFailure;

  /// Checks if the current state is related to images operations
  bool get isImagesState =>
      this is ImagesLoading || this is ImagesSuccess<T> || this is ImagesFailure;

  /// Checks if the current state is related to movie operations
  bool get isMovieState =>
      this is MovieLoading || this is MovieSuccess<T> || this is MovieFailure;

  bool get isSaveMovieState =>
      this is SaveMovieLoading || this is SaveMovieSuccess<T> || this is SaveMovieFailure;
}


