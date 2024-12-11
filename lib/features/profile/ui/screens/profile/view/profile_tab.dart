import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
import 'package:movies_app/features/main_layout/ui/widgets/movie_card.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_state.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../generated/assets.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = "profile";

  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late ThemeData theme;
  late UserEntity user;
  bool isEmptyWatchList = false;
  final ProfileCubit _profileCubit = getIt();
  @override
  void initState() {
    user = _profileCubit.currentUserData;
    _profileCubit.getWatchList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Column(
      children: [
        Container(
          color: AppColors.updateProfileBg, // Background color
          child: Column(
            children: [
              const SizedBox(height: 40), // Top padding
              Row(
                children: [
                  _buildAvatarAndName(),
                  _buildWishListAndHistory(num: "num", string: "Watch List"),
                  _buildWishListAndHistory(num: "num", string: "History"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildEditProfileButton(context),
                  _buildExitButton(context)
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black, // Background color
            child: _buildTabs(),
          ),
        ),
      ],
    );
  }

  Container _buildExitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width * .3,
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.redButton)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Exit",
                  style: theme.textTheme.displayMedium,
                ),
                const Icon(
                  Icons.exit_to_app,
                  size: 25,
                  color: AppColors.iconWhite,
                )
              ],
            )));
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .62,
        child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Edit profile",
              style: theme.textTheme.displayMedium!
                  .copyWith(color: AppColors.backgroundDark),
            )));
  }

  Column _buildAvatarAndName() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 56, left: 24, bottom: 14),
          width: 118,
          height: 118,
          child: RandomAvatar(user.avatarCode),
        ),
        Text(
          user.name,
          style: theme.textTheme.displayMedium,
        )
      ],
    );
  }

  Widget _buildWishListAndHistory(
      {required String num, required String string}) {
    return Padding(
      padding: const EdgeInsets.only(left: 55, top: 50.0),
      child: Column(
        children: [
          Text(
            num,
            style: theme.textTheme.displayLarge!.copyWith(fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(string,
              style: theme.textTheme.displayLarge!.copyWith(fontSize: 25))
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Column(
        children: [
          Container(
            color: AppColors.updateProfileBg,
            child:  TabBar(
              onTap: (value) {
                if(value == 1){
                  _profileCubit.getHistory();
                }
              },
              dividerColor: AppColors.transparent,
              indicatorColor: AppColors.textYellow,
              labelColor: AppColors.textYellow,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.list,
                    color: AppColors.iconYellow,
                    size: 30,
                  ),
                  text: 'Watch List',
                ),
                Tab(
                  icon: Icon(
                    Icons.folder,
                    color: AppColors.iconYellow,
                    size: 30,
                  ),
                  text: 'History',
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) => _profileCubit,
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return TabBarView(
                    children: [
                      state.when(
                          initial: () => loading(),
                          loading: () => loading(),
                          success: (data) {
                            List<MovieEntity> movies = data;
                            isEmptyWatchList = movies.isEmpty;
                            return isEmptyWatchList? Image.asset(Assets.imagesEmpty):_buildTabsCards(movies);
                          },
                          failure: (errorMsg) {
                            showToast(msg: errorMsg, color: Colors.red);
                            return const SizedBox.shrink();
                          },),
                      state.when(
                        initial: () => loading(),
                        loading: () => loading(),
                        success: (data) {
                          List<MovieEntity> movies = data;
                          isEmptyWatchList = movies.isEmpty;
                          return isEmptyWatchList? Image.asset(Assets.imagesEmpty):_buildTabsCards(movies);
                        },
                        failure: (errorMsg) {
                          showToast(msg: errorMsg, color: Colors.red);
                          return const SizedBox.shrink();
                        },),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTabsCards(List<MovieEntity> movies) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: movies.length,
        itemBuilder: (context, index) => MovieCard(
            movieId: movies[index].id,
            rating: movies[index].rating,
            posterPath: movies[index].posterPath!),
      ),
    );
  }
}
