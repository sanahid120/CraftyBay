import 'dart:convert';

import 'package:craftybay/app/urls.dart';
import 'package:craftybay/features/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../core/services/network_caller.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInProgress = false;
  String? _errorMessage;


  String? get errorMessage => _errorMessage;
  bool get signInProgress => _signInProgress;

  Future<bool> signIn(String email, String password) async {
    bool isSuccessful = false;
    _signInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      body: {"email": email, "password": password},
    );

    if (response.isSuccess) {

      UserModel userModel = UserModel.fromJson(response.body["data"]["user"]);
      String token = response.body['data']['token'];

      await AuthController.saveUserData(userModel, token);

      isSuccessful = true;
      _errorMessage = response.body['msg'];
    } else {
      isSuccessful = false;
      _errorMessage = response.errorMessage;
    }
    _signInProgress = false;
    notifyListeners();
    return isSuccessful;

  }

}
