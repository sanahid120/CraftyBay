import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/homepage.dart';
import '../features/auth/presentation/screens/splashScreen.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings,)
  {
    Widget widget = SizedBox();

    switch (settings.name) {

      case SplashScreen.name:
        widget = const SplashScreen();
        break;
      case Homepage.name:
        widget = const Homepage();
        break;
    }


    return MaterialPageRoute(builder: (context) => widget);
  }
}