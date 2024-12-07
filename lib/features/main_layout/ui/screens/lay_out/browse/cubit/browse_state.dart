import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../core/networking/api_error_model.dart';

part 'browse_state.freezed.dart';

@freezed
class BrowseState<T> with _$BrowseState<T>{
  const factory BrowseState.initial() = Initial;
  //Genres
  const factory BrowseState.genreLoading() = GenreLoading;
  const factory BrowseState.genreSuccess(T data) = GenreSuccess<T>;
  const factory BrowseState.genreFailure(ApiErrorModel error) = GenreFailure;

  //Movies
  const factory BrowseState.moviesLoading() = MoviesLoading;
  const factory BrowseState.moviesSuccess(T data) = MoviesSuccess<T>;
  const factory BrowseState.moviesFailure(ApiErrorModel error) = MoviesFailure;

}
extension BrowseStateExtension<T> on BrowseState<T> {
  bool get isGenreState {
    return this is GenreLoading || this is GenreFailure || this is GenreSuccess<T>;
  }
  bool get isMoviesState {
    return this is MoviesLoading || this is MoviesFailure || this is MoviesSuccess<T>;
  }
}


