import 'package:craftybay/admin/presentation/screens/add_new_product.dart';
import 'package:craftybay/features/payment/presentation/screens/payment_options.dart';
import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:craftybay/shared/presentation/screens/homepage_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    if(!mounted) return;
    Navigator.pushReplacementNamed(context, HomepageBottomNavBar.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Center(child: AppLogo())),
            CircularProgressIndicator(),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
