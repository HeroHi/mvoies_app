import 'package:flutter/material.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/assets.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "onBoarding";
  final PageController _pageController = PageController();

  List<OnBoardingPage> pages = [
    OnBoardingPage(
        title: "Find Your Next Favorite Movie Here",
        description:
            "Get access to a huge library of movies to suit all tastes. You will surely like it.",
        image: Assets.imagesMoviesPosters),
    OnBoardingPage(
        title: 'Discover Movies',
        description:
            'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
        image: Assets.imagesBoarding1),
    OnBoardingPage(
        title: 'Explore All Genres',
        description:
            'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
        image: Assets.imagesBoarding2),
    OnBoardingPage(
        title: 'Create Watchlist',
        description:
            'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
        image: Assets.imagesBoarding3),
    OnBoardingPage(
        title: 'Rate, Review, and Learn',
        description:
            "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
        image: Assets.assetsImagesBoarding4),
    OnBoardingPage(
        title: 'Start Watching Now',
        description: '',
        image: Assets.assetsImagesBoarding5)
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
                decoration: const BoxDecoration(
                    color: AppColors.sheetBlack,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      page.title,
                      style: theme.textTheme.displayMedium!.copyWith(
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      page.description,
                      style: theme.textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildUpperElevatedButton(context),
                    const SizedBox(
                      height: 15,
                    ),
                    index > 1
                        ? _buildLowerElevatedButton()
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
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
          "back",
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
              ? "Explore Now"
              : index == 5
                  ? "Finish"
                  : "Next",
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
