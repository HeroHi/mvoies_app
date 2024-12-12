import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/screens/login/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/ui/screens/login/cubit/login_state.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';

import '../../../../../../../../generated/assets.dart';
import '../../../../../widgets/my_text_field.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = "forgotPassword";

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _emailKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final LoginCubit _loginCubit = getIt();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryYellow,
                  ),
                ),
              );
            },
            success: () {
              Navigator.pop(context);
              showToast(msg: tr('forgotPassword.checkYourEmail'), color: Colors.green);
            },
            failure: (message) {
              Navigator.pop(context);
              showToast(msg: message, color: Colors.red);
            },
          );
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(Assets.imagesForgot2),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        controller: _emailController,
                        preIcon: Icons.email,
                        validator: (String value) {
                          return null;
                        },
                        hintText: tr('forgotPassword.hintEmail'),
                        isPassword: false,
                        fieldKey: _emailKey),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _loginCubit.resetPassword(_emailController.text);
                          },
                          child:  Text(tr('forgotPassword.buttonVerifyEmail')),
                    )
                    )],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.iconYellow),
      title:  Center(
        child: Text(tr('forgotPassword.title')),
      ),
    );
  }
}
