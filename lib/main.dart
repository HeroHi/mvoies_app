import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_theme.dart';
import 'package:movies_app/core/networking/supabase_helper.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import 'package:movies_app/features/auth/ui/screens/register/view/register_screen.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/lay_out.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/di/di.dart';
void main() async{
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseHelper.url,
    anonKey: SupabaseHelper.anonKey,
  );
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
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        LayOut.routeName:(_)=>LayOut()
      },
      initialRoute: LayOut.routeName,
    );
  }
}
