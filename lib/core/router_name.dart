import 'package:auth_app/pages/forgot_password_screen.dart';
import 'package:auth_app/pages/sign_up_screen.dart';
import 'package:auth_app/pages/reset_password_screen.dart';
import 'package:auth_app/pages/user_profile_screen.dart';
import 'package:flutter/material.dart';

import '../pages/login_screen.dart';

class RouteNames {
  static const String signUpScreen = '/registrationScreen';
  static const String loginScreen = '/registrationScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String userProfileScreen = '/userProfileScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SignUpScreen());
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
