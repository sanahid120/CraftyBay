import 'package:craftybay/features/category/data/models/category_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller.dart';

class CategoryListProvider extends ChangeNotifier {
  final int _pageSize = 30;
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

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<bool> getCategories() async {
    bool isSuccess = false;

    if (_lastPage != null && _currentPage >= _lastPage!) {
      return false;
    }

    _currentPage++;
    if (_isInitialLoading) {
      _initialLoadInProgress = true;
    } else {
      _loadMoreInProgress = true;
    }
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.categoriesUrl(_pageSize, _currentPage),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _initialLoadInProgress = false;
      _loadMoreInProgress = false;
      List<CategoryModel> tempCategoriesList = [];

      for (Map<String, dynamic> category in response.body['data']['results']) {
        tempCategoriesList.add(CategoryModel.fromJson(category));
      }
      _categories.addAll(tempCategoriesList);
      _lastPage = response.body['data']['last_page'] ?? _lastPage;
      notifyListeners();

      return isSuccess;
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
