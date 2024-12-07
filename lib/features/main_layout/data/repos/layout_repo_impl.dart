import 'package:injectable/injectable.dart';
import 'package:movies_app/core/networking/api_error_handler.dart';
import 'package:movies_app/core/networking/api_result.dart';
import 'package:movies_app/features/main_layout/data/ds/api_services.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';

import '../../domain/repos/layout_repo.dart';
import '../model/genre_response.dart';
@Singleton(as: LayoutRepo)
class LayoutRepoImpl extends LayoutRepo{
  final ApiServices _apiServices;
  LayoutRepoImpl(this._apiServices);
  @override
  Future<ApiResult<List<MovieEntity>>> getMoviesByCategory(String categoryId) async{
    try {
      var response =  await _apiServices.getMoviesByCategory(categoryId);
      return ApiResult.success((response.results.map((e) => e.toEntity(),)).toList());
    }  catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  @override
  Future<ApiResult<List<MovieEntity>>> getPopularMovies() async{
    try {
      var response =  await _apiServices.getPopularMovies();
      return ApiResult.success((response.results.map((e) => e.toEntity(),)).toList());
    }  catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  @override
  Future<ApiResult<List<MovieEntity>>> search(String q) async{
    try {
      var response =  await _apiServices.getPopularMovies();
      return ApiResult.success((response.results.map((e) => e.toEntity(),)).toList());
    }  catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }
  @override
  Future<ApiResult<List<Genre>>> getGenres() async{
    try {
      var response = await _apiServices.getGenres();
      return ApiResult.success(response.genres);
    }catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }
}