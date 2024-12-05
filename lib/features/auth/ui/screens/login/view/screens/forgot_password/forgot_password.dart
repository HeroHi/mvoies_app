import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName="forgotPassword";
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(children: [
        ListView(
          children: [
            // Load a Lottie file from your assets
            Lottie.asset('assets/LottieLogo1.json'),

            // Load a Lottie file from a remote url
            Lottie.network(
                'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),

            // Load an animation and its images from a zip file
            Lottie.asset('assets/lottiefiles/angel.zip'),
          ],
        ),      ],),
    );
  }

  _buildAppBar() {
    return AppBar(
      // leading: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.arrowLeft)),
      iconTheme: IconThemeData(color: AppColors.iconYellow),
      title: Center(child: Text("Forgot password "),),
    );
  }
}
