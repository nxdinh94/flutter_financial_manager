

import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/repository/app_repository.dart';
import 'package:flutter/foundation.dart';

class AppViewModel extends ChangeNotifier{

  final AppRepository _appRepository = AppRepository();


  ApiResponse _iconCategoriesData = ApiResponse.loading();
  ApiResponse get iconCategoriesData => _iconCategoriesData;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  void setIconsCategoriesData(ApiResponse value) {
    _iconCategoriesData = value;
    notifyListeners();
  }
  Future<void> getIconCategoriesApi() async {
      setLoading(true);
      await _appRepository.getIconCategoriesApi().then((value) {
        setIconsCategoriesData(ApiResponse.completed(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}