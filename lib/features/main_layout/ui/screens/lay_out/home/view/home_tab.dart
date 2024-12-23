import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/home/cubit/home_cubit.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/home/cubit/home_state.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
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
  String currentMoviePoster = "https://cdn.photoroom.com/v1/assets-cached.jpg?path=backgrounds_v3/black/Photoroom_black_background_extremely_fine_texture_only_black_co_b99c8103-0e9c-41eb-a7f8-4f121d0a28cb.jpg";
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
      child:Column(
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                Container(
                  foregroundDecoration:const BoxDecoration(gradient: LinearGradient(end: Alignment.bottomCenter, colors: [
                    Color(0xCC121312),
                    Color(0x99121312),
                    Color(0xcc121312)
                  ])) ,
                  height: MediaQuery.of(context).size.height,
                  decoration:  BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.4,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(currentMoviePoster))),
                ),
                Column(
                  children: [
                    _buildAvailableNow(),
                    _buildCarouselSlider(),
                  ],
                ),
                Positioned(
                  top: 350.h,
                  child: Padding(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 81.w),
                      child: SizedBox(
                          width: 250.w,
                          height: 200.h,
                          child: Image.asset(Assets.imagesWatcNow))),
                )
              ],
            ),
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
        padding:  EdgeInsets.symmetric(horizontal: 81.w, vertical: 8.h),
        child: Image.asset(Assets.imagesAvailableNow));
  }

  Widget _buildCategoryAndSeeMoreRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tr('home.action'),
          style: theme.textTheme.displayMedium,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            "${tr('home.seeMore')} ->   ",
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
          initial: () => loading(),
          popularLoading: () =>
              loading(),
          popularSuccess: (movies) => CarouselSlider.builder(
            itemCount: movies.length,
            itemBuilder: (context, index, realIndex) {
              final MovieEntity movie = movies[index];
              if(index == 0){
                currentMoviePoster = movie.posterPath!;
              }
              return MovieCard(
                movieId: movie.id,
                  rating: movie.rating, posterPath: movie.posterPath!);
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                final MovieEntity movie = movies[index];
                currentMoviePoster = movie.posterPath!;
                setState(() {});
              },
              aspectRatio: 1.4,
              viewportFraction: 0.5,
              enlargeFactor: 0.5,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enlargeCenterPage: true,
            ),
          ),
          popularFailure: (error) => Center(
            child: Text(
              error.message ?? tr('searchScreen.anErrorOccurred'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          orElse: () => loading(),
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
          initial: () => loading(),
          byGenreLoading: () =>
              loading(),
          byGenreSuccess: (movies) => SingleChildScrollView(
            child: CarouselSlider.builder(
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                final MovieEntity movie = movies[index];
                return MovieCard(
                  movieId: movie.id,
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
              error.message ?? tr('searchScreen.anErrorOccurred'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
          orElse: () => loading(),
        );
      },
    );
  }
}
