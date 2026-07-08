import 'package:flutter/material.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'Content-Type': 'application/json',
      // If you have a token, add it here separately
      // 'token': 'your_token_here' 
    },
    onUnauthorize: () {
      logout();
    },
  );
}

Future<void> logout() async {
  if (MyApp.navigatorKey.currentContext != null) {
    Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentContext!, SignInScreen.name, (route) => false);
  }
}
