import '../../../../core/networking/api_result.dart';
import '../../data/model/genre_response.dart';
import '../entities/movie_entity.dart';

abstract class LayoutRepo{
  Future<ApiResult<List<MovieEntity>>> getPopularMovies();
  Future<ApiResult<List<MovieEntity>>> getMoviesByCategory(String categoryId);
  Future<ApiResult<List<MovieEntity>>> search(String q);
  Future<ApiResult<List<Genre>>> getGenres();
}