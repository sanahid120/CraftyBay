import 'dart:convert';

import 'package:craftybay/app/urls.dart';
import 'package:craftybay/features/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../core/services/network_caller.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _signUpInProgress = false;
  String? _errorMessage;


  String? get errorMessage => _errorMessage;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> verifyOTP(String email, String otp) async {
    bool isSuccessful = false;
    _signUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.verifyOTP,
      body: {"email": email, "otp": otp},
    );

    if (response.isSuccess) {
      //save user model to local storage
      //save token to local storage
      UserModel userModel = UserModel.fromJson(response.body["data"]["user"]);
      String token = response.body['data']['token'];

      await AuthController.saveUserData(userModel, token);

      isSuccessful = true;
      _errorMessage = response.body['msg'];
    } else {
      isSuccessful = false;
      _errorMessage = response.errorMessage;
    }
    _signUpInProgress = false;
    notifyListeners();
    return isSuccessful;

  }

}
