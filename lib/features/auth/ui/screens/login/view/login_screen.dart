import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/screens/login/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/ui/screens/login/cubit/login_state.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/screens/forgot_password/forgot_password.dart';
import 'package:movies_app/features/auth/ui/screens/register/view/register_screen.dart';
import 'package:movies_app/features/auth/ui/widgets/country_switch.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/lay_out.dart';
import '../../../../../../generated/assets.dart';
import '../../../widgets/show_toast.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _emailKey = GlobalKey();

  final GlobalKey<FormState> _passwordKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final LoginCubit _loginCubit = getIt();

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocProvider(
      create: (context) => _loginCubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              showDialog(
                context: context,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            },
            success: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, LayOut.routeName);
            },
            failure: (message) {
              Navigator.pop(context);
              showToast(msg: message, color: Colors.red);
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundDark,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Image.asset(Assets.imagesLogo),
                ),
                MyTextField(
                    controller: _emailController,
                    preIcon: Icons.email,
                    validator: (String value) {
                      return _validateEmail(value);
                    },
                    hintText: "Email",
                    isPassword: false,
                    fieldKey: _emailKey),
                MyTextField(
                    controller: _passwordController,
                    preIcon: FontAwesomeIcons.lock,
                    validator: (value) {
                      if (value.length < 8) {
                        return "Password should be at least 8 characters";
                      }
                      return null;
                    },
                    hintText: "password",
                    isPassword: true,
                    fieldKey: _passwordKey),
                buildForgotPassword(),
                _buildLoginButton(),
                buildCreateAccount(),
                buildOR(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 18, left: 14, right: 14),
                  child: ElevatedButton(
                    onPressed: () {
                      _loginCubit.loginWithGoogle();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata_outlined),
                        Text("login with google")
                      ],
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 140),
                    child: CountrySwitch())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      child: ElevatedButton(
          onPressed: () {
            if (_passwordKey.currentState!.validate() &&
                _emailKey.currentState!.validate()) {
              _loginCubit.login(
                  _emailController.text, _passwordController.text);
            }
          },
          child: const Text("login")),
    );
  }

  Row buildOR() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 92,
          height: 1.12,
          color: AppColors.textYellow,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28),
          child: Text(
            "OR",
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textYellow),
          ),
        ),
        Container(
          width: 92,
          height: 1.12,
          color: AppColors.textYellow,
        ),
      ],
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          " Don’t Have Account ?",
          style: theme.textTheme.labelSmall,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RegisterScreen.routeName);
          },
          child: Text(" Create One ",
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: AppColors.textYellow)),
        )
      ],
    );
  }

  Row buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ForgotPassword.routeName);
          },
          child: Text(
            "Forgot password ?",
            style: theme.textTheme.labelSmall
                ?.copyWith(color: AppColors.textYellow),
          ),
        ),
        const SizedBox(
          width: 14,
        )
      ],
    );
  }

  String? _validateEmail(String value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
