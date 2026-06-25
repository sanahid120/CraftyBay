import 'package:craftybay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/homepage.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/splashScreen.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();

    switch (settings.name) {
      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case SignInScreen.name:
        widget = const SignInScreen();
        break;
      case Homepage.name:
        widget = const Homepage();
        break;
      case SignUpScreen.name:
        widget = SignUpScreen();
    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
