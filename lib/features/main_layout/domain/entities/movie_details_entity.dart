import '../../data/model/genre_response.dart';

class MovieDetailsEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int popularity;
  final double voteAverage;
  final List<Genre> genres;

  MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.popularity,
    required this.voteAverage,
    required this.genres,
  });
}
