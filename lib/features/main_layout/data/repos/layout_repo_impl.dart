import 'package:injectable/injectable.dart';
import 'package:movies_app/core/networking/api_error_handler.dart';
import 'package:movies_app/core/networking/api_result.dart';
import 'package:movies_app/core/services/database_service.dart';
import 'package:movies_app/features/main_layout/data/ds/api_services.dart';
import 'package:movies_app/features/main_layout/domain/entities/backdrop_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/cast_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';

import '../../domain/repos/layout_repo.dart';
import '../model/genre_response.dart';
@Singleton(as: LayoutRepo)
class LayoutRepoImpl extends LayoutRepo{
  final ApiServices _apiServices;
  final DatabaseService _databaseService;
  LayoutRepoImpl(this._apiServices,this._databaseService);
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
  Future<ApiResult<List<MovieEntity>>> search({required String q,required int page}) async{
    try {
      var response =  await _apiServices.search(q: q, page: page);
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

  @override
  Future<ApiResult<MovieDetailsEntity>> getMovie(int movieId) async{
    try {
      var response = await _apiServices.getMovie(movieId);
      return ApiResult.success(response.toEntity());
    }catch (error) {
      print(error.toString());
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  @override
  Future<ApiResult<List<CastEntity>>> getCast(int movieId) async{
    try {
      var response = await _apiServices.getMovieCredits(movieId);
      return ApiResult.success(response.cast.map((e) => e.toEntity(),).toList());
    }catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }

  @override
  Future<ApiResult<List<MovieEntity>>> getSimilarMovies(int movieId) async{
    try {
      var response = await _apiServices.getSimilerMovies(movieId);
      return ApiResult.success(response.results.map((e) => e.toEntity(),).toList());
    }catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }
  @override
  Future<ApiResult<List<BackdropEntity>>> getScreenshots(int movieId) async{
    try {
      var response = await _apiServices.getMovieImages(movieId);
      return ApiResult.success(response.backdrops!.map((e) => e.toEntity(),).toList());
    }catch (error) {
      return ApiResult.failure(ApiErrorHandler.handleError(error));
    }
  }
  @override
  Future<void> addToWatchList(
      {required MovieEntity movie})async{
       Map<String,dynamic> json = {
         'id':movie.id,
         'posterPath':movie.posterPath,
         'rating':movie.rating
       };
    await _databaseService.insertData(path: 'watchList', data: json, documentId: movie.id.toString());
  } Future<void> addToHistory(
      {required MovieEntity movie})async{
       Map<String,dynamic> json = {
         'id':movie.id,
         'posterPath':movie.posterPath,
         'rating':movie.rating
       };
    await _databaseService.insertData(path: 'history', data: json, documentId: movie.id.toString());
  }
}