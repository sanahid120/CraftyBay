import 'package:craftybay/features/products/data/model/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class ProductListProvider extends ChangeNotifier {
  final int _pageSize = 15;
  int _currentPage = 0;
  int? _lastPage;
  bool _initialLoadInProgress = false;
  bool _loadMoreInProgress = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  bool get initialLoadInProgress => _initialLoadInProgress;
  bool get loadMoreInProgress => _loadMoreInProgress;

  final List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<bool> getProducts(String categoryId) async {
    bool isSuccess = false;

    if (_lastPage != null && _currentPage >= _lastPage!) {
      return false;
    }

    _currentPage++;
    if (_isInitialLoading) {
      _products.clear();
      _initialLoadInProgress = true;
    } else {
      _loadMoreInProgress = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.productListByCategoryUrl(_pageSize, _currentPage, categoryId),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _initialLoadInProgress = false;
      _loadMoreInProgress = false;
      List<ProductModel> tempProductList = [];

      for (Map<String, dynamic> product in response.body['data']['results']) {
        tempProductList.add(ProductModel.fromJson(product));
      }
      _products.addAll(tempProductList);
      _lastPage = response.body['data']['last_page'] ?? _lastPage;
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }
    _initialLoadInProgress = false;
    _loadMoreInProgress = false;
    notifyListeners();
    return isSuccess;
  }

  bool get _isInitialLoading => _currentPage == 1;
}
