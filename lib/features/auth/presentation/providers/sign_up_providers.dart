import 'package:flutter/material.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';
import '../../data/models/sign_up_params.dart';

class SignUpProviders extends ChangeNotifier {
  bool isPasswordVisible = true;
  bool _signUpInProgress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(SignUpParams params) async {
    bool isSuccessful = false;
    _signUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signUpUrl,
      body: params.toJson(),

    );

    if (response.isSuccess) {
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
