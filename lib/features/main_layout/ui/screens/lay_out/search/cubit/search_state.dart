import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../core/networking/api_error_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState<T> with _$SearchState<T>{
  const factory SearchState.initial() = Initial;

  //Movies
  const factory SearchState.moviesLoading() = MoviesLoading;
  const factory SearchState.moviesSuccess(T data) = MoviesSuccess<T>;
  const factory SearchState.moviesFailure(ApiErrorModel error) = MoviesFailure;

}


