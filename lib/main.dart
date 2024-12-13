import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_theme.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/login_screen.dart';
import 'package:movies_app/features/auth/ui/screens/login/view/screens/forgot_password/forgot_password.dart';
import 'package:movies_app/features/auth/ui/screens/register/view/register_screen.dart';
import 'package:movies_app/features/main_layout/ui/on_boarding/on_boarding_screen.dart';
import 'package:movies_app/features/main_layout/ui/screens/details/view/details_screen.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/lay_out.dart';
import 'package:movies_app/features/main_layout/ui/splash/splash.dart';
import 'package:movies_app/features/profile/ui/screens/reset_password/reset_password.dart';
import 'package:movies_app/features/profile/ui/screens/update_profile/view/update_profile_screen.dart';
import 'core/di/di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 851),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.theme,
            routes: {
              RegisterScreen.routeName: (_) => RegisterScreen(),
              LoginScreen.routeName: (_) => LoginScreen(),
              LayOut.routeName: (_) => LayOut(),
              DetailsScreen.routeName: (_) => DetailsScreen(),
              ForgotPassword.routeName: (_) => ForgotPassword(),
              UpdateProfileScreen.routeName: (_) => UpdateProfileScreen(),
              ResetPassword.routeName: (_) => ResetPassword(),
              SplashScreen.routeName:(_)=>SplashScreen(),
              OnboardingScreen.routeName:(_)=>OnboardingScreen()
            },
            initialRoute: (FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified)
                ? LayOut.routeName
                : SplashScreen.routeName,
          );
        });
  }
}
