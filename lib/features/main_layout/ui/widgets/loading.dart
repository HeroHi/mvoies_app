import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

Widget loading(){
  return const Center(child: CircularProgressIndicator(color: AppColors.primaryYellow,),);
}