import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
        current: _currentCountry,
        values: [0, 1],
        onChanged: (i) => setState(() => _currentCountry = i),
        iconBuilder: (value, foreground) => countries[value],
        // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
        style: ToggleStyle(
          backgroundColor: AppColors.transparent,
          borderColor: AppColors.primaryYellow,
          indicatorColor: AppColors.primaryYellow,
        ), // optional style settings
         // many more parameters available
    );
  }
}
