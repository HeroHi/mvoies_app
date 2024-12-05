import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../widgets/country_switch.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _emailKey = GlobalKey();
  final GlobalKey<FormState> _passwordKey = GlobalKey();
  final GlobalKey<FormState> _nameKey = GlobalKey();
  final GlobalKey<FormState> _passwordConfirmKey = GlobalKey();
  final GlobalKey<FormState> _phoneKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  static const String routeName = "Register";
  late ThemeData theme;
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Register"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAvatarSelector(),
          MyTextField(
              preIcon: FontAwesomeIcons.idCard,
              validator: (value) {
                if (value.length < 4) {
                  return "At least 4 characters";
                }
                return null;
              },
              hintText: "Name",
              isPassword: false,
              fieldKey: _nameKey),
          MyTextField(
              preIcon: FontAwesomeIcons.envelope,
              validator: _validateEmail,
              hintText: "Email",
              isPassword: false,
              fieldKey: _emailKey),
          MyTextField(
              preIcon: FontAwesomeIcons.lock,
              validator: (value) {
                if (value.length < 8) {
                  return "Password should be at least 8 characters";
                }
                return null;
              },
              hintText: "Password",
              isPassword: true,
              fieldKey: _passwordKey),
          MyTextField(
              preIcon: FontAwesomeIcons.lock,
              validator: _validatePassConfirm,
              hintText: "Confirm Password",
              isPassword: true,
              fieldKey: _passwordConfirmKey),
          MyTextField(
              preIcon: FontAwesomeIcons.phone,
              validator: _validatePhone,
              hintText: "Phone Number",
              isPassword: false,
              fieldKey: _phoneKey),
          _buildRegisterButton(),
          const SizedBox(
            height: 15,
          ),
          _buildLoginText(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 140),
            child: CountrySwitch(),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("Create Account"),
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have Account ?",
          style: theme.textTheme.labelSmall,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            " Login",
            style: theme.textTheme.labelSmall!
                .copyWith(color: AppColors.primaryYellow),
          ),
        )
      ],
    );
  }

  Widget _buildAvatarSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
          items: _buildAvatars(),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            aspectRatio: 2.5,
            viewportFraction: 0.36,
          )),
    );
  }

  List<Widget> _buildAvatars() {
    return [
      RandomAvatar("saytoonz"),
      RandomAvatar("john_doe"),
      RandomAvatar("user-123"),
      RandomAvatar("flutter_dev"),
      RandomAvatar("tech_guy"),
      RandomAvatar("superstar123"),
      RandomAvatar("user42"),
      RandomAvatar("cool_user"),
      RandomAvatar("happy_person"),
    ];
  }

  String? _validateEmail(String value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassConfirm(String value) {
    String password = _passwordController.text;
    if (value != password) {
      return "Password and Password Confirm not match";
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (!value.startsWith("01") || value.length != 11) {
      return "Invalid Phone number";
    }
    return null;
  }
}
