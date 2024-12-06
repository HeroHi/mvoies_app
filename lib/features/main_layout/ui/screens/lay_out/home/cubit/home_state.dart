import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/core/networking/api_error_model.dart';

part 'home_state.freezed.dart';
@freezed
class HomeState<T> with _$HomeState<T>{
  const factory HomeState.initial() = Initial;
  //Popular Movies
  const factory HomeState.popularLoading() = PopLoading;
  const factory HomeState.popularSuccess(T data) = PopSuccess<T>;
  const factory HomeState.popularFailure(ApiErrorModel error) = PopFailure;

  //Moves by genre
  const factory HomeState.byGenreLoading() = ByGLoading;
  const factory HomeState.byGenreSuccess(T data) = ByGSuccess<T>;
  const factory HomeState.byGenreFailure(ApiErrorModel error) = ByGFailure;
}

