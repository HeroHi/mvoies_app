import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import '../../../../../../generated/assets.dart';

class HomeTab extends StatelessWidget {
  late ThemeData theme;
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              height: MediaQuery.of(context).size.height * .52,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(Assets.imagesTest))),
              child: Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 81, vertical: 8),
                      child: Image.asset(Assets.assetsImagesAvailableNow)),
                  _buildCarouselSlider()
                ],
              )),
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 81, vertical: 8),
                    child: Image.asset(Assets.assetsImagesWatcNow)),
                _buildCategoryAndSeeMoreRow(),
                _buildCategoryScroll()
              ],
            ))
      ],
    );
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

  Padding _buildCarouselSlider() {
    return Padding(
      padding: EdgeInsets.all(1),
      child: CarouselSlider(
          items: _buildCarouselSliderItems(),
          options: CarouselOptions(
            height: 320.0,
            // autoPlay: true,
            // autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 0.5,
            aspectRatio: 16 / 9,
            initialPage: 0,
          )),
    );
  }

  List<Widget> _buildCarouselSliderItems() {
    return [
      Image.asset(Assets.imagesTest),
      Image.asset(Assets.imagesLogo),
      Image.asset(Assets.imagesTest),
      Image.asset(Assets.imagesLogo)
    ];
  }

  Widget _buildCategoryScroll() {
    return Padding(
      padding: EdgeInsets.all(1),
      child: CarouselSlider(
          items: _buildCarouselSliderItems(),
          options: CarouselOptions(
            height: 200.0,
            viewportFraction: 0.4,
            aspectRatio: 16 / 9,
            initialPage: 0,
          )),
    );
  }
}
