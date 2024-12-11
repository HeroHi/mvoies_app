import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/data/model/genre_response.dart';
import 'package:movies_app/features/main_layout/domain/entities/backdrop_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/cast_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/screens/details/cubit/details_cubit.dart';
import 'package:movies_app/features/main_layout/ui/screens/details/cubit/details_state.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../widgets/movie_card.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late ThemeData theme;
  late final int movieId;
  late final MovieEntity currentMovie;
  final DetailsCubit _detailsCubit = getIt();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        movieId = ModalRoute.of(context)!.settings.arguments as int;
        _detailsCubit.getMovie(movieId).then(
          (value) {
            _detailsCubit.getCast(movieId);
            _detailsCubit.getSimilarMovies(movieId);
            _detailsCubit.getImages(movieId);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocProvider(
  create: (context) => _detailsCubit,
  child: Scaffold(
      appBar:_buildAppBar(),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        buildWhen: (previous, current) => current.isMovieState,
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => loading(),
            movieLoading: () => loading(),
            movieFailure: (error) {
              showToast(msg: error.message!, color: Colors.red);
              return const SizedBox.shrink();
            },
            movieSuccess: (data) {
              MovieDetailsEntity movie = data;
              currentMovie = MovieEntity(rating: movie.voteAverage, id: movie.id,posterPath: movie.posterPath);
              _detailsCubit.addToHistory(currentMovie);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMovie(
                        posterPath: movie.posterPath,
                        title: movie.title,
                        year: movie.releaseDate.substring(0, 4)),
                    _buildWatchButton(),
                    _buildMovieRatings(movie),
                    _buildTitles("Screen Shots"),
                    BlocBuilder<DetailsCubit, DetailsState>(
                      buildWhen: (previous, current) => current.isImagesState,
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => loading(),
                          imagesLoading: () => loading(),
                          imagesFailure: (error) {
                            showToast(msg: error.message!, color: Colors.red);
                            return const SizedBox.shrink();
                          },
                          imagesSuccess: (data) {
                            List<BackdropEntity> screenshots = data;
                            return _buildScreenShotsList(screenshots);
                          },
                        );
                      },
                    ),
                    _buildTitles("Similar"),
                    BlocBuilder<DetailsCubit, DetailsState>(
                      buildWhen: (previous, current) =>
                          current.isSimilarState,
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => loading(),
                          similarLoading: () => loading(),
                          similarFailure: (error) {
                            showToast(msg: error.message!, color: Colors.red);
                            return const SizedBox.shrink();
                          },
                          similarSuccess: (data) {
                            List<MovieEntity> movies = data;
                            return _buildSimilarGrid(movies);
                          },
                        );
                      },
                    ),
                    _buildTitles("Summary"),
                    _buildSummary(movie.overview),
                    _buildTitles("Cast"),
                    BlocBuilder<DetailsCubit, DetailsState>(
                      buildWhen: (previous, current) => current.isCastState,
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => loading(),
                          castLoading: () => loading(),
                          castFailure: (error) {
                            showToast(msg: error.message!, color: Colors.red);
                            return const SizedBox.shrink();
                          },
                          castSuccess: (data) {
                            List<CastEntity> cast = data;
                            return _buildCast(cast);
                          },
                        );
                      },
                    ),
                    _buildTitles("Genres"),
                    _buildAllGenres(movie.genres)
                  ],
                ),
              );
            },
          );
        },
      ),
    ),
);
  }

  AppBar _buildAppBar() {

    return AppBar(backgroundColor: AppColors.transparent,automaticallyImplyLeading: true,
      actions: [
        IconButton(onPressed: () {
          _detailsCubit.addToWatchList(currentMovie);
        }, icon: const Icon(Icons.bookmark))
      ]
      ,);
  }

    Row _buildMovieRatings(MovieDetailsEntity movie) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildRectangle(icon: Icons.favorite, number: movie.popularity),
          _buildRectangle(
              icon: Icons.access_time_filled_outlined, number: movie.popularity),
          _buildRectangle(icon: Icons.star, number: movie.voteAverage),
        ],
      );
    }

    Column _buildScreenShotsList(List<BackdropEntity> screenshots) {
      return Column(
        children: List.generate(
          3,
              (index) => _buildScreenShot(image: screenshots[index].filePath!),
        ),
      );
    }

    Column _buildCast(List<CastEntity> cast) {
      return Column(
        children: List.generate(
          4,
              (index) => _buildCard(
            image: cast[index].profilePath ?? "",
            name: cast[index].name,
            role: cast[index].character,
          ),
        ),
      );
    }

    Container _buildAllGenres(List<Genre> genres) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: genres.length,
          itemBuilder: (context, index) =>
              _buildGenresContainer(genres[index].name),
        ),
      );
    }

    Container _buildMovie(
        {required String posterPath,
          required String title,
          required String year}) {
      return Container(
          height: MediaQuery.sizeOf(context).height * .52,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(posterPath),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 248,
              ),
              GestureDetector(onTap: () {}, child: _buildPlayIcon()),
              const Spacer(),
              _buildTitles(title),
              _buildTitles(year)
            ],
          ));
    }

    Container _buildSummary(String summery) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          summery,
          style: theme.textTheme.labelSmall,
        ),
      );
    }

    SizedBox _buildSimilarGrid(List<MovieEntity> movies) {
      return SizedBox(
        height: 600,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          itemCount: 4,
          itemBuilder: (context, index) => MovieCard(
            movieId: movies[index].id,
            rating: movies[index].rating,
            posterPath: movies[index].posterPath!,
          ),
        ),
      );
    }

    Padding _buildTitles(String title) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: theme.textTheme.displayLarge,
        ),
      );
    }

    Padding _buildWatchButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.redButton)),
            onPressed: () {},
            child: Text(
              "watch",
              style: theme.textTheme.displayLarge,
            )),
      );
    }

    Container _buildPlayIcon() {
      return Container(
          width: 97,
          height: 97,
          decoration: const BoxDecoration(
            color: AppColors.iconYellow,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.iconWhite, // Transparent center effect
              ),
              child: Center(
                child: Container(
                  width: 67,
                  height: 67,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.iconYellow, // Transparent center effect
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 50, // Play icon size
                  ),
                ),
              ),
            ),
          ));
    }

    Widget _buildRectangle({required IconData icon, required num number}) {
      return Container(
        width: 122,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.bottomNav,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: AppColors.iconYellow,
              size: 36,
            ),
            Text(
              "$number",
              style: theme.textTheme.displayLarge,
            )
          ],
        ),
      );
    }

    Widget _buildGenresContainer(String string) {
      return Container(
        width: 110,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.bottomNav,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              string,
              style: theme.textTheme.labelSmall,
            )
          ],
        ),
      );
    }

    Widget _buildScreenShot({required String image}) {
      return Container(
        margin: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * .2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                fit: BoxFit.cover, image: CachedNetworkImageProvider(image))),
      );
    }

    Widget _buildCard(
        {required String image, required String name, required String role}) {
      return Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: AppColors.bottomNav, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Row(
            children: [
              _buildActorImage(image),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Name: $name",
                      style: theme.textTheme.labelSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        " Character: $role",
                        style: theme.textTheme.labelSmall,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildActorImage(String image) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover, image: CachedNetworkImageProvider(image))),
      );
    }
  }

