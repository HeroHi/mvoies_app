import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_theme.dart';
import 'package:movies_app/features/auth/ui/screens/register/view/register_screen.dart';

void main() async{
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routes: {
        RegisterScreen.routeName:(_)=>RegisterScreen()
      },
      initialRoute: RegisterScreen.routeName,
    );
  }
}
