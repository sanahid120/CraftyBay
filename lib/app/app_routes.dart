import 'package:craftybay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:craftybay/features/auth/presentation/screens/verify_otp.dart';
import 'package:craftybay/shared/presentation/screens/homepage_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/homepage.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/splashScreen.dart';
import '../features/category/presentaion/screens/category_screen.dart';
import '../features/products/presentation/screens/product_list_screen.dart';

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
        break;
      case VerifyOtp.name:
        widget = VerifyOtp();
      break;
      case HomepageBottomNavBar.name:
        widget = HomepageBottomNavBar();
        break;
      case ProductListScreen.name:
        final categoryName = settings.arguments as String;
        widget = ProductListScreen(categoryName: categoryName,);
        break;
      case CategoryScreen.name:
        widget = CategoryScreen();
        break;
      default:


    }

    return MaterialPageRoute(builder: (context) => widget);
  }
}
