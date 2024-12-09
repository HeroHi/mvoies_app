import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/data/model/credits_response.dart';
import 'package:movies_app/features/main_layout/data/model/genre_response.dart';
import 'package:movies_app/features/main_layout/data/model/movie_details_dm.dart';
import 'package:movies_app/features/main_layout/data/model/movie_dm.dart';
import 'package:movies_app/features/main_layout/data/model/movies_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
part 'api_services.g.dart';
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;
  @GET(ApiConstants.popMoviesEndPoint)
  Future<MoviesResponse> getPopularMovies();
  
  @GET(ApiConstants.moviesByCategoryEndPoint)
  Future<MoviesResponse> getMoviesByCategory(@Query('with_genres') String categoryId);

  @GET(ApiConstants.genresEndPoint)
  Future<GenresResponse> getGenres();

  @GET(ApiConstants.searchEndPoint)
  Future<MoviesResponse> search(
      {@Query('query') required String q, @Query('page') required int page});

  @GET(ApiConstants.similarMoviesEndPoint)
  Future<MoviesResponse> getSimilerMovies(@Path() int movieId);

  @GET(ApiConstants.movieEndPoint)
  Future<MovieDetailsDM> getMovie(@Path() int movieId);

  @GET(ApiConstants.creditsEndPoint)
  Future<CreditsResponse> getMovieCredits(@Path() int movieId);


}

