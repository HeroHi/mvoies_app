import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/home/cubit/home_cubit.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/home/cubit/home_state.dart';
import 'package:movies_app/features/main_layout/ui/widgets/movie_card.dart';
import '../../../../../../../generated/assets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ThemeData theme;
  final HomeCubit _homeCubit = getIt();
  @override
  void initState() {
    _homeCubit.getPopMovies();
    _homeCubit.getMoviesByCategory("28");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocProvider(
      create: (context) => _homeCubit,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.imagesTest))),
                child: Column(
                  children: [
                    _buildAvailableNow(),
                    _buildCarouselSlider(),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 81, vertical: 8),
                        child: Image.asset(Assets.imagesWatcNow))
                  ],
                )),
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  _buildCategoryAndSeeMoreRow(),
                  _buildCategoryScroll()
                ],
              ))
        ],
      ),
    );
  }

  Padding _buildAvailableNow() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 81, vertical: 8),
        child: Image.asset(Assets.imagesAvailableNow));
  }

  Row _buildCategoryAndSeeMoreRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "  Action",
          style: theme.textTheme.displayMedium,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "See More ->   ",
            style: theme.textTheme.displayMedium!
                .copyWith(color: AppColors.textYellow),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is PopLoading ||
            current is PopFailure ||
            current is PopSuccess;
      },
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const Center(child: CircularProgressIndicator()),
          popularLoading: () =>
              const Center(child: CircularProgressIndicator()),
          popularSuccess: (movies) => CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (context, index, realIndex) {
              final MovieEntity movie = movies[index];
              return MovieCard(
                  rating: movie.rating, posterPath: movie.posterPath!);
            },
            options: CarouselOptions(
              aspectRatio: 1.4,
              viewportFraction: 0.5,
              enlargeFactor: 0.5,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enlargeCenterPage: true,
            ),
          ),
          popularFailure: (error) => Center(
            child: Text(
              error.message ?? "An error occurred",
              style: const TextStyle(color: Colors.red),
            ),
          ),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildCategoryScroll() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is ByGFailure || current is ByGLoading || current is ByGSuccess;
      },
      builder: (context, state) {
        return state.maybeWhen(
          initial: () => const Center(child: CircularProgressIndicator()),
          byGenreLoading: () =>
              const Center(child: CircularProgressIndicator()),
          byGenreSuccess: (movies) => SingleChildScrollView(
            child: CarouselSlider.builder(
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                final MovieEntity movie = movies[index];
                return MovieCard(
                    rating: movie.rating, posterPath: movie.posterPath!);
              },
              options: CarouselOptions(
                aspectRatio: 1.4,
                viewportFraction:0.5,
                enlargeCenterPage: false,
              ),
            ),
          ),
          byGenreFailure: (error) => Center(
            child: Text(
              error.message ?? "An error occurred",
              style: const TextStyle(color: Colors.red),
            ),
          ),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
