import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/core/networking/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class DioModule {
  @singleton
  Dio provideDio() {
    Duration timeout = const Duration(seconds: 30);
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: timeout, // 5 seconds
        receiveTimeout: timeout, // 5 seconds
        headers: {
          'accept': 'application/json',
          'Authorization':
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNTE3NjQwZjUxYWRiOGFlODEzZmE1MGEzNmM5OWMxYiIsIm5iZiI6MTczMzE3MDU1NC43MjQsInN1YiI6IjY3NGUxNTdhMjNkZjk2MGRjNGNkNzQ2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.iA9Jv9NpXmkQiAmkk0YhgXczNut2Prs4akdXLMYGtAU"
        },
      ),
    );

    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
    ));

    return dio;
  }
}
