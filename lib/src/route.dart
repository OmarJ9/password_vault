import 'package:flutter/material.dart';
import 'constants/strings.dart';
import 'screens/tabs/passgen_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/pin_screen.dart';
import 'screens/verification_screen.dart';

class AppRoute {
  AppRoute();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        {
          return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        }
      case authscreen:
        {
          return MaterialPageRoute(builder: (_) => const AuthScreen());
        }
      case verificationscreen:
        final String number = settings.arguments as String;
        {
          return MaterialPageRoute(
              builder: (_) => VerificationScreen(
                    mynumber: number,
                  ));
        }
      case pinscreen:
        {
          return MaterialPageRoute(
            builder: (_) => const PinScreen(),
          );
        }

      case homescreen:
        {
          return MaterialPageRoute(builder: (_) => const HomeScreen());
        }

      case passgenscreen:
        final bool fromaddpass = settings.arguments as bool;
        {
          return MaterialPageRoute(builder: (_) => PassGenScreen(fromaddpass));
        }

      default:
        throw 'No Page Found!!';
    }
  }
}
