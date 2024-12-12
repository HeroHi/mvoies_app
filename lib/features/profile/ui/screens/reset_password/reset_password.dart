import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/validators.dart';
import 'package:movies_app/features/auth/ui/widgets/my_text_field.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = "resetPassword";
  final GlobalKey<FormState> _passwordKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _confirmPasswordKey = GlobalKey();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Reset password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
            ),
            MyTextField(
                preIcon: Icons.password,
                validator: Validators.passValidator,
                hintText: "Enter New Password",
                isPassword: true,
                fieldKey: _passwordKey,
                controller: _passwordController),
            MyTextField(
                preIcon: Icons.password,
                validator: Validators.passValidator,
                hintText: "Re-enter New Password",
                isPassword: true,
                fieldKey: _confirmPasswordKey,
                controller: _confirmPasswordController),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Reset password")),
            ),
          ],
        ),
      ),
    );
  }
}
