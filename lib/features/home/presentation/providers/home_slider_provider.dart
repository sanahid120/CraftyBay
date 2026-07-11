
import 'package:craftybay/core/services/network_caller.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/network_caller_set_up.dart';
import '../../../../app/urls.dart';
import '../../data/models/slider_model.dart';

class HomeSliderProvider extends ChangeNotifier{

  bool _getHomeSlidersInProgress =false;
  bool get getHomeSlidersInProgress => _getHomeSlidersInProgress;

  final List<SliderModel> _homeSliders = [];
  List<SliderModel> get homeSliders => _homeSliders;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> getSlidersData() async {
    bool isSuccess = true;
    _getHomeSlidersInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().getRequest(
      Urls.sliderUrl,
    );
    if (response.isSuccess) {
      _homeSliders.clear();
      List<SliderModel> sliders = [];
      for (var slider in response.body['data']['results']) {
        sliders.add(SliderModel.fromJson(slider));
      }
      _homeSliders.addAll(sliders);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }
    _getHomeSlidersInProgress = false;
    notifyListeners();

    return isSuccess;







  }





}