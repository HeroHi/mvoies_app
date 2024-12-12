import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/search/cubit/search_cubit.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/search/cubit/search_state.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../widgets/movie_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool _isSearching = false;
  final SearchCubit _searchCubit = getIt();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchCubit,
      child: Column(
        children: [
           SizedBox(
            height: 22.h,
          ),
          _buildSearchField(),
          _isSearching
              ? _searchedItemGrid()
              : Expanded(child: Image.asset(Assets.imagesEmpty))
        ],
      ),
    );
  }

  Widget _searchedItemGrid() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return const SizedBox.shrink();
          },
          moviesLoading: () {
            return loading();
          },
          moviesSuccess: (data) {
            List<MovieEntity> movies = data;
            return Expanded(
              child: GridView.builder(
                gridDelegate: _gridDelegate(),
                itemCount: movies.length,
                itemBuilder: (context, index) => MovieCard(
                  movieId: movies[index].id,
                    rating: movies[index].rating,
                    posterPath: movies[index].posterPath!),
              ),
            );
          },
          moviesFailure: (error) {
            showToast(
                msg: error.message ?? "An error occurred", color: Colors.red);
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10.r,
        crossAxisSpacing: 10.r);
  }

  Widget _buildSearchField() {
    return Container(
      height: 56.h,
      margin:  EdgeInsets.all(14.r),
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xff282A28),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
           Padding(
            padding: EdgeInsets.only(left: 10.0.r, right: 8.r),
            child: const Icon(
              FontAwesomeIcons.searchengin,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "search",
                hintStyle: TextStyle(color: Colors.white),
              ),
              onFieldSubmitted: (q) {
                _searchFor(q);
              },
            ),
          )
        ],
      ),
    );
  }

  void _searchFor(String q) {
    _searchCubit.searchForMovies(q: q, page: 1);
    _startSearching();
  }

  void _startSearching() {
    _stopSearching();
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    if (_searchController.text.isEmpty) {
      _clearSearch();
      _isSearching = false;
      setState(() {});
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }
}
