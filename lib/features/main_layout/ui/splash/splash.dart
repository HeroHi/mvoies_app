import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/lay_out.dart';
import '../../../../../generated/assets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName="splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacementNamed(context, LayOut.routeName);
      },
    );
    return Scaffold(
      body: Center(
        child:Image.asset(Assets.imagesLogo),
      ),
    );
  }
}
