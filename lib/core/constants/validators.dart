import 'package:flutter/cupertino.dart';

abstract class Validators {
  static String? validateEmail(String value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassConfirm(
      String value, TextEditingController passwordController) {
    String password = passwordController.text;
    if (value != password) {
      return "Password and Password Confirm not match";
    }
    return null;
  }

  static String? validatePhone(String value) {
    if (!value.startsWith("01") || value.length != 11) {
      return "Invalid Phone number";
    }
    return null;
  }

  static String? passValidator(String value) {
    if (value.length < 8) {
      return "Password should be at least 8 characters";
    }
    return null;
  }
}
