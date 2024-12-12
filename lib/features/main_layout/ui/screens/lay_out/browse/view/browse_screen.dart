import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/data/model/genre_response.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/browse/cubit/browse_cubit.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/browse/cubit/browse_state.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../widgets/custom_choice_chip.dart';
import '../../../../widgets/movie_card.dart';

class BrowseScreen extends StatefulWidget {
  static const routeName = "Browse";
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final BrowseCubit _browseCubit = getIt();
  int selectedGenreIndex = 0;
  late int genreId;
  @override
  void initState() {
    _browseCubit.getGenres();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _browseCubit,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40.h, child: _buildGenresBloc()),
            _buildMoviesBloc()
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesBloc() {
    return BlocBuilder<BrowseCubit, BrowseState>(
      buildWhen: (previous, current) => current.isMoviesState,
      builder:(context, state) {
      return state.maybeWhen(initial: () {
        return loading();
      }, moviesLoading: () {
        return loading();
      }, moviesSuccess: (data) {
        List<MovieEntity> movies = data;
        return _buildMovies(movies);
      }, moviesFailure: (error) {
        showToast(
            msg: error.message ?? tr('searchScreen.anErrorOccurred'), color: Colors.red);
        return const SizedBox.shrink();
      }, orElse: () {
        return loading();
      });
    },
    );
  }

  Expanded _buildMovies(List<MovieEntity> movies) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: _gridDelegate(),
        itemCount: movies.length,
        itemBuilder: (context, index) =>  MovieCard(
          movieId: movies[index].id,
          posterPath: movies[index].posterPath!,
          rating: movies[index].rating,
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10.r,
        crossAxisSpacing: 10.r);
  }

  Widget _buildGenresBloc() {
    return BlocBuilder<BrowseCubit, BrowseState>(
      buildWhen: (previous, current) {
        return current.isGenreState;
      },
      builder: (context, state) {
        return state.maybeWhen(initial: () {
          return loading();
        }, genreLoading: () {
          return loading();
        }, genreSuccess: (data) {
          List<Genre> genres = data;
          if(selectedGenreIndex == 0){
            genreId = genres[0].id;
            _browseCubit.getMoviesByCategory(genreId.toString());
          }
          return _buildGenresTabs(genres);
        }, genreFailure: (error) {
          showToast(
              msg: error.message ?? tr('searchScreen.anErrorOccurred'), color: Colors.red);
          return const SizedBox.shrink();
        }, orElse: () {
          return loading();
        });
      },
    );
  }

  ListView _buildGenresTabs(List<Genre> genres) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: genres.length,
      itemBuilder: (context, index) => CustomChoiceChip(
          label: genres[index].name,
          onSelected: () {
            genreId = genres[index].id;
            selectedGenreIndex = index;
            setState(() {});
            _browseCubit.getMoviesByCategory(genreId.toString());
          },
          isSelected: index == selectedGenreIndex),
    );
  }
}
