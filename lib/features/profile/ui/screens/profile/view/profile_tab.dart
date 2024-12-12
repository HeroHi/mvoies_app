import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/main_layout/domain/entities/movie_entity.dart';
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
import 'package:movies_app/features/main_layout/ui/widgets/movie_card.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_state.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/view/update_profile_screen.dart';
import 'package:random_avatar/random_avatar.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../generated/assets.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = "profile";

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late ThemeData theme;
  late UserEntity user;
  bool isEmptyWatchList = false;
  final ProfileCubit _profileCubit = getIt();
  List<MovieEntity> history = [];
  List<MovieEntity> watchList = [];
  @override
  void initState() {
    user = UserEntity(avatarCode: "avatarCode", name: "name", email: "email", phone: "phone");
    _fetchUserData();
    _profileCubit.getWatchList();
    _profileCubit.getHistory();


    super.initState();
  }
  void _fetchUserData() async {
    user = await _profileCubit.currentUserData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocProvider(
      create: (context) => _profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
  listener: (context, state) {
    {
      state.when(
        initial: () {
        },
        loading: () {

        },
        success: (data) {
            watchList = data;
        },
        failure: (errorMsg) {
          _dismissDialog();
          showToast(msg: errorMsg, color: Colors.red);
        },
        historyLoading: () async{
        },
        historySuccess: (data) {
          _dismissDialog();
          setState(() {
            history = data;
          });
        },
        historyFailure: (errorMsg) {
          _dismissDialog();
          showToast(msg: errorMsg, color: Colors.red);

        },
      );
    }
  },
  child: Column(
        children: [
          Container(
            color: AppColors.updateProfileBg, // Background color
            child: Column(
              children: [
                const SizedBox(height: 40), // Top padding
                Row(
                  children: [
                    _buildAvatarAndName(),
                    _buildWishListAndHistory(
                        num: "${watchList.length}", string: tr('profileScreen.watchList')),
                    _buildWishListAndHistory(
                        num: "${history.length}", string: tr('profileScreen.history')),
                  ],
                ),
                 SizedBox(height: 20.h),
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
      ),
),
    );
  }

  Container _buildExitButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        width: 0.3.sw,
        child: ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.redButton)),
            onPressed: () {
              _profileCubit.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tr('profileScreen.exit'),
                  style: theme.textTheme.displayMedium,
                ),
                 Icon(
                  Icons.exit_to_app,
                  size: 25.r,
                  color: AppColors.iconWhite,
                )
              ],
            )));
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return SizedBox(
        width: 0.62.sw,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, UpdateProfileScreen.routeName);
            },
            child: Text(
              tr('profileScreen.editProfile'),
              style: theme.textTheme.displayMedium!
                  .copyWith(color: AppColors.backgroundDark),
            )));
  }

  Column _buildAvatarAndName() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 56, left: 24, bottom: 14),
          width: 118.w,
          height: 118.h,
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
      padding: const EdgeInsets.only(left: 10, top: 50.0),
      child: Column(
        children: [
          Text(
            num,
            style: theme.textTheme.displayLarge!.copyWith(fontSize: 25.sp),
          ),
           SizedBox(
            height: 20.h,
          ),
          Text(string,
              style: theme.textTheme.displayLarge!.copyWith(fontSize: 25.sp))
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
              dividerColor: AppColors.transparent,
              indicatorColor: AppColors.textYellow,
              labelColor: AppColors.textYellow,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: const Icon(
                    Icons.list,
                    color: AppColors.iconYellow,
                    size: 30.r,
                  ),
                  text: tr('profileScreen.watchList'),
                ),
                 Tab(
                  icon: const Icon(
                    Icons.folder,
                    color: AppColors.iconYellow,
                    size: 30.r,
                  ),
                  text: tr('profileScreen.history'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTabsCards(watchList),
                _buildTabsCards(history)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLoading() async{
        if (context.mounted) {
          await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryYellow,
            ),
          ),
             );
        }

  }

  Widget _buildTabsCards(List<MovieEntity> movies) {
    return movies.isEmpty
        ? _buildEmptyImage()
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
              gridDelegate: _gridDelegate(),
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieCard(
                  movieId: movies[index].id,
                  rating: movies[index].rating,
                  posterPath: movies[index].posterPath!),
            ),
          );
  }

  SliverGridDelegateWithFixedCrossAxisCount _gridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10);
  }

  _buildEmptyImage() {
    return Image.asset(Assets.imagesEmpty);
  }
  void _dismissDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
