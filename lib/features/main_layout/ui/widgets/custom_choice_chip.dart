import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onSelected;
  CustomChoiceChip(
      {super.key,
        required this.label,
        required this.onSelected,
        required this.isSelected});
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        onSelected: (value) {
          onSelected();
        },
        label: Text(label),
        selected: isSelected,
        showCheckmark: false,
        selectedColor: AppColors.primaryYellow,
        backgroundColor: Colors.black,
        labelStyle: isSelected
            ? theme.textTheme.displayMedium!
            .copyWith(color: AppColors.backgroundDark)
            : theme.textTheme.displayMedium!
            .copyWith(color: AppColors.primaryYellow),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: AppColors.primaryYellow)),
      ),
    );
  }
}