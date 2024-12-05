import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/auth/ui/widgets/country_switch.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';
import '../../../../../../generated/assets.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  LoginScreen({super.key});
  GlobalKey<FormState> _fieldKey = GlobalKey();
  GlobalKey<FormState> _secFieldKey = GlobalKey();
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .3,
            child: Image.asset(Assets.imagesLogo),
          ),
          MyTextField(
              preIcon: Icons.email,
              validator: (String h) {
                return h;
              },
              hintText: "hintText",
              isPassword: true,
              fieldKey: _fieldKey),
          MyTextField(
              preIcon: Icons.email,
              validator: (String h) {
                return h;
              },
              hintText: "hintText",
              isPassword: true,
              fieldKey: _secFieldKey),
          buildForgotPassword(),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, bottom: 18, left: 14, right: 14),
            child: ElevatedButton(onPressed: () {}, child: const Text("login")),
          ),
          buildCreateAccount(),
          buildOR(),
          Padding(
            padding:
                const EdgeInsets.only(top: 18, bottom: 18, left: 14, right: 14),
            child: ElevatedButton(
                onPressed: () {},
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata_outlined),
                    Text("login with google")
                  ],
                )),
          ),
  Padding(
      padding: EdgeInsets.symmetric(vertical: 18,horizontal: 140),
      child: const CountrySwitch())
        ],
      ),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28),
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
}
