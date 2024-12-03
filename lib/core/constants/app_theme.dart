import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_styles.dart';

abstract class AppTheme {
  static ThemeData theme = ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme:  AppBarTheme(
        iconTheme: const IconThemeData(
          color: AppColors.primaryYellow,
          size: 30,
        ),
        centerTitle: true,
        titleTextStyle: AppStyles.w400Style.copyWith(color: AppColors.primaryYellow),
        color: AppColors.transparent,
      ),
      textTheme: TextTheme(
        labelSmall: AppStyles.w400Style,
        displayLarge: AppStyles.boldStyle,
        displayMedium: AppStyles.w400Style.copyWith(fontSize: 20),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.iconWhite,
        size: 30,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          fixedSize: const Size.fromWidth(500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: AppStyles.w400Style.copyWith(fontSize: 20),
          backgroundColor: AppColors.primaryYellow,
        ),
      ),

  );
}
