import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/generated/assets.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(Assets.imagesTest,fit: BoxFit.fill,width: double.infinity,)),
        _buildRating(context),
      ],
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
            "7.7",
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

}