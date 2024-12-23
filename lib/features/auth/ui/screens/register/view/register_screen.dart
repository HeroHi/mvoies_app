import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:movies_app/features/main_layout/ui/widgets/loading.dart';
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
  late List<String> avatars;
  String selectedAvatar = "saytoonz";

  final RegisterCubit _registerCubit = getIt();

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
              builder: (context) => loading(),);
          }, success: () {
            Navigator.pop(context);
            showToast(
                msg: tr('register.signupSuccess'),
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
            title:  Text(tr('register.title')),
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
                        return tr('register.validationName');
                      }
                      return null;
                    },
                    hintText: tr('register.nameHint'),
                    isPassword: false,
                    fieldKey: _nameKey),
                MyTextField(
                  controller: _emailController,
                    preIcon: FontAwesomeIcons.envelope,
                    validator: _validateEmail,
                    hintText: tr('register.emailHint'),
                    isPassword: false,
                    fieldKey: _emailKey),
                MyTextField(
                  controller: _passwordController,
                    preIcon: FontAwesomeIcons.lock,
                    validator: (value) {
                      if (value.length < 8) {
                        return tr('register.validationPassword');
                      }
                      return null;
                    },
                    hintText: tr('register.passwordHint'),
                    isPassword: true,
                    fieldKey: _passwordKey),
                MyTextField(
                  controller: _passwordConfirmController,
                    preIcon: FontAwesomeIcons.lock,
                    validator: _validatePassConfirm,
                    hintText: tr('register.confirmPasswordHint'),
                    isPassword: true,
                    fieldKey: _passwordConfirmKey),
                MyTextField(
                  controller: _phoneController,
                    preIcon: FontAwesomeIcons.phone,
                    validator: _validatePhone,
                    hintText: tr('register.phoneHint'),
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
            UserEntity user = UserEntity(name: _nameController.text, phone: _phoneController.text, email: _emailController.text, avatarCode: selectedAvatar);
            await _registerCubit.register(user, _passwordController.text);

          }
        },
        child:  Text(tr('register.createAccountButton')),
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr('register.alreadyHaveAccount'),
          style: theme.textTheme.labelSmall,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            tr('login.title'),
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
            onPageChanged: (index, reason) {
              selectedAvatar = avatars[index];
            },
            enlargeCenterPage: true,
            enlargeFactor: 0.5,
            aspectRatio: 2.5,
            viewportFraction: 0.36,
          )),
    );
  }

  List<Widget> _buildAvatars() {
    avatars = ["saytoonz","john_doe","user-123","flutter_dev","tech_guy","superstar123","user42","cool_user","happy_person"];
    return List.generate(avatars.length, (index) => RandomAvatar(avatars[index]),);
  }

  String? _validateEmail(String value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return tr('register.validationEmail');
    }
    return null;
  }

  String? _validatePassConfirm(String value) {
    String password = _passwordController.text;
    if (value != password) {
      return tr('register.validationPasswordConfirm');
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (!value.startsWith("01") || value.length != 11) {
      return tr('register.validationPhone');
    }
    return null;
  }
}
