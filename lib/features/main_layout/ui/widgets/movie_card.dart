import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final double rating;
  const MovieCard({super.key, required this.rating, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: posterPath,
              placeholder: (context, url) => Skeletonizer(
                enabled: true,
                  child: Image.asset(Assets.imagesTeeest)),
            ),
          ),
          _buildRating(context),
        ],
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      width: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Row(
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Spacer(),
          const Icon(
            Icons.star,
            size: 25,
            color: AppColors.primaryYellow,
          ),
        ],
      ),
    );
  }
  static Widget get skeleton{
    return const MovieCard(rating: 7.7, posterPath: Assets.imagesTeeest);
  }
}
