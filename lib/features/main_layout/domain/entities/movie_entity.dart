class MovieEntity {
  final double rating;
  final String? posterPath;
  final int id;

  MovieEntity({
    required this.rating,
    this.posterPath,
    required this.id,
  });
}
