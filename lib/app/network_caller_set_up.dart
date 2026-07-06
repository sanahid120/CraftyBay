import 'package:flutter/material.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {'token': 'content-type: application/json'},
    onUnauthorize: () {
      logout();
    },
  );
}

Future<void> logout() async {
  Navigator.pushNamedAndRemoveUntil(MyApp.navigatorKey.currentContext!, SignInScreen.name, (route) => false);
}

