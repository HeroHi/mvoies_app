import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/validators.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_cubit.dart';
import 'package:movies_app/features/profile/ui/screens/profile/cubit/profile_state.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/cubit/update_profile_cubit.dart';

import '../update_profile/cubit/update_profile_state.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = "resetPassword";
  final GlobalKey<FormState> _passwordKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _confirmPasswordKey = GlobalKey();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final UpdateProfileCubit _updateProfileCubit = getIt();
  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateProfileCubit,
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          state.when(
            loading: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryYellow,
                  ),

                );
              },success: () {
                Navigator.pop(context);
                showToast(msg: tr('resetPassword.passwordUpdatedSuccess'), color: Colors.green);
              },failure: (errorMsg) {
                Navigator.pop(context);
                showToast(msg: errorMsg, color: Colors.red);
              }, initial: () { },);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title:  Text(tr('resetPassword.resetPassword')),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:  0.25.sh,
                ),
                MyTextField(
                    preIcon: Icons.password,
                    validator: Validators.passValidator,
                    hintText: tr('resetPassword.enterNewPassword'),
                    isPassword: true,
                    fieldKey: _passwordKey,
                    controller: _passwordController),
                MyTextField(
                    preIcon: Icons.password,
                    validator: (value) {
                      return Validators.validatePassConfirm(
                          value, _passwordController);
                    },
                    hintText: tr('resetPassword.reEnterNewPassword'),
                    isPassword: true,
                    fieldKey: _confirmPasswordKey,
                    controller: _confirmPasswordController),
                Padding(
                  padding:  EdgeInsets.all(16.0.r),
                  child: ElevatedButton(
                      onPressed: () {
                        _updateProfileCubit.updatePassword(_passwordController.text);
                      },
                      child:  Text(tr('resetPassword.resetPasswordButton'))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
