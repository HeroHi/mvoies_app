import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../generated/assets.dart';
import '../../widgets/movie_card.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = "details";
  late ThemeData theme;
  DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * .52,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(Assets.imagesTest))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 248,
                          ),
                          GestureDetector(
                              onTap: () {}, child: _buildPlayIcon()),
                          const Spacer(),
                          _buildTitles("Movie Title"),
                          _buildTitles("2022")
                        ],
                      )),
                ],
              ),
              _buildWatchButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRectangle(icon: Icons.favorite, number: "11"),
                  _buildRectangle(
                      icon: Icons.access_time_filled_outlined, number: "11"),
                  _buildRectangle(icon: Icons.star, number: "11"),
                ],
              ),
              _buildTitles("Screen Shots"),
              _buildScreenShot(context: context, image: Assets.imagesTest),
              _buildScreenShot(context: context, image: Assets.imagesTest),
              _buildScreenShot(context: context, image: Assets.imagesTest),
              _buildTitles("Similar"),
              _buildSimilarGrid(),
              _buildTitles("Summary"),
              _buildSummary(),
              _buildTitles("Card"),
              _buildCard(
                  image: Assets.assetsImagesActor,
                  name: "Whoever",
                  role: "serial KILLER"),
              _buildCard(
                  image: Assets.assetsImagesActor,
                  name: "Whoever",
                  role: "serial KILLER"),
              _buildCard(
                  image: Assets.assetsImagesActor,
                  name: "Whoever",
                  role: "serial KILLER"),
              _buildTitles("Genres"),
              Container(
                padding: EdgeInsets.all(10),
                height: 150,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 5,
                  itemBuilder: (context, index) =>
                      _buildGenresContainer("string"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Container _buildSummary() {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
        style: theme.textTheme.labelSmall,
      ),
    );
  }

  SizedBox _buildSimilarGrid() {
    return SizedBox(
      height: 600,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: 4,
        itemBuilder: (context, index) =>  MovieCard(rating: 7.7, posterPath: '',),
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

  Widget _buildRectangle({required IconData icon, required String number}) {
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
            number,
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
            style: theme.textTheme.displayLarge,
          )
        ],
      ),
    );
  }

  Widget _buildScreenShot(
      {required BuildContext context, required String image}) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * .2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
    );
  }

  Widget _buildCard(
      {required String image, required String name, required String role}) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 92,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.bottomNav, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          _buildActorImage(image),
          Column(
            children: [
              Text(
                "Name: $name",
                style: theme.textTheme.labelSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  " Role: $role",
                  style: theme.textTheme.labelSmall,
                ),
              )
            ],
          )
        ],
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
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
    );
  }
}
