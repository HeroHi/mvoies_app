abstract class ApiConstants{
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String popMoviesEndPoint = "movie/popular";
  static const String genresEndPoint = "genre/movie/list";
  static const String moviesByCategoryEndPoint = "discover/movie";
  static const String imagesBaseUrl="https://image.tmdb.org/t/p/w500";
  static const String searchEndPoint = 'search/movie';
  static const String similarMoviesEndPoint = 'movie/{movieId}/similar';
  static const String movieEndPoint = 'movie/{movieId}';
  static const String creditsEndPoint = 'movie/{movieId}/credits';
  static const String imagesEndPoint = 'movie/{movieId}/images';

}