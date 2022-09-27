import '../modules/authentication/pages/forgot_password_screen.dart';
import '../modules/authentication/pages/sign_up_screen.dart';
import '../modules/authentication/pages/reset_password_screen.dart';
import '../modules/authentication/pages/user_profile_screen.dart';
import 'package:flutter/material.dart';

import '../modules/authentication/pages/login_screen.dart';
import '../modules/authentication/pages/verify_screen.dart';

class RouteNames {
  static const String signUpScreen = '/signUpScreen';
  static const String loginScreen = '/loginScreen';
  static const String verifyScreen = '/verifyScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String userProfileScreen = '/userProfileScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SignUpScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => LoginScreen());
      case RouteNames.verifyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => VerifyScreen());
      case RouteNames.forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ForgotPasswordScreen());
      case RouteNames.resetPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => ResetPasswordScreen());
      case RouteNames.userProfileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UserProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
