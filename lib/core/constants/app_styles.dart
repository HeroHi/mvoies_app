import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyles{
  static const TextStyle w400Style = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );
  static const TextStyle boldStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textLight,
  );
}