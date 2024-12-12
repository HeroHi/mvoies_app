import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';

class CountrySwitch extends StatefulWidget {
  const CountrySwitch({super.key});

  @override
  State<CountrySwitch> createState() => _CountrySwitchState();
}

class _CountrySwitchState extends State<CountrySwitch> {
  List<Widget> countries = [
  CountryFlag.fromCountryCode(
  'US',
  shape: const Circle(),
  ),
    CountryFlag.fromCountryCode(
      'EG',
      shape: const Circle(),
    ),
  ];
  int _currentCountry = 0;
  List<String> langCodes=['en','ar'];
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
        current: _currentCountry,
        values: const [0, 1],
        onChanged: (i) {
          context.setLocale(Locale(langCodes[i]));
          setState(() => _currentCountry = i);},
        iconBuilder: (value, foreground) => countries[value],
        // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
        style: const ToggleStyle(
          backgroundColor: AppColors.transparent,
          borderColor: AppColors.primaryYellow,
          indicatorColor: AppColors.primaryYellow,
        ), // optional style settings
         // many more parameters available
    );
  }
}
