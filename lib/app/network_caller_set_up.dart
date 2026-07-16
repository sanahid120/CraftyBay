import 'package:craftybay/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import '../core/services/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import 'app.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: ()  {
      Map <String, String> headers = {
        'Content-Type': 'application/json',
        // If you have a token, add it here separately
        'token': AuthController.token!
      };
      if(AuthController.token!=null){
        headers['token'] =  '${AuthController.token}';
      }
      return headers;
    },

    onUnauthorize: () {
      AuthController.removeUserData();
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
