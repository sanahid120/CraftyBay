import 'package:craftybay/core/services/network_caller.dart';
import 'package:craftybay/features/products/presentation/models/cart_model.dart';
import 'package:flutter/widgets.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _addToCartInProgress = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  bool get addToCartInProgress => _addToCartInProgress;

  Future<bool> addToCart(CartModel params) async {
    _addToCartInProgress = true;
    notifyListeners();
    bool isSuccess = false;

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.addToCart,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _addToCartInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
