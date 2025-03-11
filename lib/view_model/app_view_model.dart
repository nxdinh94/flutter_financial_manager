

import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/repository/app_repository.dart';
import 'package:flutter/foundation.dart';

class AppViewModel extends ChangeNotifier{

  final AppRepository _appRepository = AppRepository();

  // Icon Categories
  ApiResponse _iconCategoriesData = ApiResponse.loading();
  ApiResponse get iconCategoriesData => _iconCategoriesData;

  ApiResponse _iconWalletTypeData = ApiResponse.loading();
  ApiResponse get iconWalletTypeData => _iconWalletTypeData;

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
  void setIconsWalletTypeData(ApiResponse<List<WalletTypeIconModel>> value) {
    _iconWalletTypeData = value;
    notifyListeners();
  }
  Future<void> getIconsWalletType() async {
      setLoading(true);
      await _appRepository.getIconsWalletTypeDataApi().then((value) {
        List<WalletTypeIconModel> list = [];
        value.forEach((element) {
          list.add(WalletTypeIconModel.fromJson(element));
        });
        setIconsWalletTypeData(ApiResponse.completed(list));
        setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}