import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/features/main_layout/data/model/genre_response.dart';
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
  

}
