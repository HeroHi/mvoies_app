import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/assets.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "onBoarding";
  final PageController _pageController = PageController();

  List<OnBoardingPage> pages = [
    OnBoardingPage(
        title: tr('onboarding.titles.findMovie'),
        description: tr('onboarding.descriptions.findMovie'),
        image: Assets.imagesMoviesPosters),
    OnBoardingPage(
        title: tr('onboarding.titles.discover'),
        description: tr('onboarding.descriptions.discover'),
        image: Assets.imagesBoarding1),
    OnBoardingPage(
        title: tr('onboarding.titles.exploreGenres'),
        description: tr('onboarding.descriptions.exploreGenres'),
        image: Assets.imagesBoarding2),
    OnBoardingPage(
        title: tr('onboarding.titles.createWatchlist'),
        description: tr('onboarding.descriptions.createWatchlist'),
        image: Assets.imagesBoarding3),
    OnBoardingPage(
        title: tr('onboarding.titles.rateReviewLearn'),
        description: tr('onboarding.descriptions.rateReviewLearn'),
        image: Assets.imagesBoarding4),
    OnBoardingPage(
        title: tr('onboarding.titles.startWatching'),
        description: '',
        image: Assets.imagesBoarding5)
  ];
  OnboardingScreen({super.key});

// @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              controller: _pageController,
              allowImplicitScrolling: false,
              itemBuilder: (context, index) {
                return OnBoardingScreenWidget(
                  page: pages[index],
                  index: index,
                  pageController: _pageController,
                );
              }),
        )
      ],
    );
  }
}

class OnBoardingScreenWidget extends StatelessWidget {
  final OnBoardingPage page;
  late ThemeData theme;
  int index;
  late PageController pageController;

  List<LinearGradient> gradients = const [
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(0x1e1e1e),
      Color(0x80121312),
    ]),
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(
        0x84250,
      ),
      Color(
        0xff084250,
      )
    ]),
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(
        0x85210e,
      ),
      Color(
        0xff85210E,
      )
    ]),
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(
        0x84250,
      ),
      Color(
        0xff4C2471,
      )
    ]),
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(
        0x84250,
      ),
      Color(
        0xff601321,
      )
    ]),
    LinearGradient(end: Alignment.bottomLeft, colors: [
      Color(
        0x84250,
      ),
      Color(
        0xff2A2C30,
      )
    ]),
  ];

  List<Color> colors = const [
    Color(0xff111312),
    Color(
      0xFF084250,
    ),
    Color(0xff8a220f),
    Color(0xff492570),
    Color(0xff641924),
    Color(0xff292d33)
  ];

  OnBoardingScreenWidget(
      {super.key,
      required this.page,
      required this.index,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _buildImageContainer(),
        ),
        Container(
          color: colors[index],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration:  BoxDecoration(
                    color: AppColors.sheetBlack,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r))),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      page.title,
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      page.description,
                      style: theme.textTheme.displayMedium,
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    _buildUpperElevatedButton(context),
                     SizedBox(
                      height: 15.h,
                    ),
                    index > 1
                        ? _buildLowerElevatedButton()
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ElevatedButton _buildLowerElevatedButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transparent,
            side: const BorderSide(color: AppColors.iconYellow)),
        onPressed: () {
          if (index > 0) {
            index--;
            pageController.jumpToPage(index);
          }
        },
        child: Text(
          tr('onboarding.buttons.back'),
          style: theme.textTheme.displayMedium,
        ));
  }

  ElevatedButton _buildUpperElevatedButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (index < 6) {
            index++;
          }
          if (index == 6) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
          pageController.jumpToPage(index);
        },
        child: Text(
          index == 0
              ? tr('onboarding.buttons.exploreNow')
              : index == 5
                  ? tr('onboarding.buttons.finish')
                  : tr('onboarding.buttons.next'),
          style: theme.textTheme.displayMedium!
              .copyWith(color: AppColors.backgroundDark),
        ));
  }

  Container _buildImageContainer() {
    return Container(
      foregroundDecoration: BoxDecoration(gradient: gradients[index]),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(page.image))),
    );
  }
}

class OnBoardingPage {
  String title;
  String image;
  String description;
  OnBoardingPage(
      {required this.title, required this.description, required this.image});
}
