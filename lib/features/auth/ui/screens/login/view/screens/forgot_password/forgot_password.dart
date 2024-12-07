import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/constants/app_colors.dart';

import '../../../../../../../../generated/assets.dart';
import '../../../../../widgets/my_text_field.dart';

class ForgotPassword extends StatelessWidget {
  static const routeName = "forgotPassword";
  final GlobalKey<FormState> _emailKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Lottie.asset(Assets.assetsAnimationForgotPassword),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: _emailController,
                    preIcon: Icons.email,
                    validator: (String value) {
                      return null;
                    },
                    hintText: "Email",
                    isPassword: false,
                    fieldKey: _emailKey),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {}, child:const Text("Verify Email")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.iconYellow),
      title: const Center(
        child: Text("Forgot password "),
      ),
    );
  }
}
