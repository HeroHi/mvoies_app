import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

abstract class Validators {
  static String? validateEmail(String value) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return tr('register.validationEmail');
    }
    return null;
  }

  static String? validatePassConfirm(
      String value, TextEditingController passwordController) {
    String password = passwordController.text;
    if (value != password) {
      return tr('register.validationPasswordConfirm');
    }
    return null;
  }

  static String? validatePhone(String value) {
    if (!value.startsWith("01") || value.length != 11) {
      return tr('register.validationPhone');
    }
    return null;
  }

  static String? passValidator(String value) {
    if (value.length < 8) {
      return tr('register.validationPassword');
    }
    return null;
  }
}
