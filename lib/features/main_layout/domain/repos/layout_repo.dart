import 'package:movies_app/features/main_layout/domain/entities/backdrop_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/cast_entity.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/model/genre_response.dart';
import '../entities/movie_details_entity.dart';
import '../entities/movie_entity.dart';

abstract class LayoutRepo {
  Future<ApiResult<List<MovieEntity>>> getPopularMovies();
  Future<ApiResult<List<MovieEntity>>> getMoviesByCategory(String categoryId);
  Future<ApiResult<List<MovieEntity>>> search(
      {required String q, required int page});
  Future<ApiResult<List<Genre>>> getGenres();
  Future<ApiResult<MovieDetailsEntity>> getMovie(int movieId);
  Future<ApiResult<List<CastEntity>>> getCast(int movieId);
  Future<ApiResult<List<MovieEntity>>> getSimilarMovies(int movieId);
  Future<ApiResult<List<BackdropEntity>>> getScreenshots(int movieId);
  Future<void> addToWatchList({
    required MovieEntity movie,
  });
  Future<void> addToHistory({
    required MovieEntity movie,
  });
}
