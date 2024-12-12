import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/di/di.dart';
import 'package:movies_app/features/auth/ui/screens/register/cubit/register_cubit.dart';
import 'package:movies_app/features/auth/ui/screens/register/cubit/register_state.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import 'package:movies_app/features/auth/ui/widgets/show_toast.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../../data/model/user_data.dart';
import '../../../widgets/country_switch.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _passwordConfirmKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordConfirmController =
  TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  late ThemeData theme;

  final RegisterCubit _registerCubit = getIt();

  @override
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return BlocProvider(
      create: (context) => _registerCubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          state.when(initial: () {
          }, loading: () {

             showDialog(context: context,
              builder: (context) => const Center(child: CircularProgressIndicator()),);
          }, success: () {
            Navigator.pop(context);
            showToast(
                msg: "signed up successfully, please check your email to verify before logging in",
                color: Colors.green);
          }, failure: (message) {
            Navigator.pop(context);
            showToast(msg: message, color: Colors.red);
          },);
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.primaryYellow),
            automaticallyImplyLeading: true,
            title: const Text("Register"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAvatarSelector(),
                MyTextField(
                  controller: _nameController,
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
                  controller: _emailController,
                    preIcon: FontAwesomeIcons.envelope,
                    validator: _validateEmail,
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
                    hintText: "Password",
                    isPassword: true,
                    fieldKey: _passwordKey),
                MyTextField(
                  controller: _passwordConfirmController,
                    preIcon: FontAwesomeIcons.lock,
                    validator: _validatePassConfirm,
                    hintText: "Confirm Password",
                    isPassword: true,
                    fieldKey: _passwordConfirmKey),
                MyTextField(
                  controller: _phoneController,
                    preIcon: FontAwesomeIcons.phone,
                    validator: _validatePhone,
                    hintText: "Phone Number",
                    isPassword: false,
                    fieldKey: _phoneKey),
                _buildRegisterButton(),
                 SizedBox(
                  height: 15.h,
                ),
                _buildLoginText(),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 140.w),
                  child: const CountrySwitch(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ElevatedButton(
        onPressed: () async{
          if (_emailKey.currentState!.validate() &&
              _nameKey.currentState!.validate() &&
              _passwordKey.currentState!.validate() &&
              _passwordConfirmKey.currentState!.validate() &&
              _phoneKey.currentState!.validate()) {
            UserEntity user = UserEntity(name: _nameController.text, phone: _phoneController.text, email: _emailController.text, avatarCode: "saytoonz");
            await _registerCubit.register(user, _passwordController.text);

          }
        },
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
          onTap: () {
            Navigator.pop(context);
          },
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
