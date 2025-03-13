
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/model/wallet_type_icon_model.dart';
import 'package:fe_financial_manager/repository/wallet_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class WalletViewModel extends ChangeNotifier{

  final WalletRepository _walletRepository = WalletRepository();

  ApiResponse _iconWalletTypeData = ApiResponse.loading();
  ApiResponse get iconWalletTypeData => _iconWalletTypeData;

  ApiResponse _allWalletData = ApiResponse.loading();
  ApiResponse get allWalletData => _allWalletData ;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }
  void setIconsWalletTypeData(ApiResponse<List<WalletTypeIconModel>> value) {
    _iconWalletTypeData = value;
    notifyListeners();
  }
  void setWalletData(ApiResponse<List<WalletModel>> value) {
    _allWalletData = value;
    notifyListeners();
  }
  Future<void> getIconsWalletType() async {
    setLoading(true);
    await _walletRepository.getIconsWalletTypeDataApi().then((value) {
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
  Future<void> createWallet(Map<String, dynamic> data, BuildContext context)async{
    setLoading(false);
    await _walletRepository.createWalletApi(data).then((value){
      Utils.toastMessage(value['message']);
      context.pop();
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> getAllWallet()async{
    setLoading(false);
    await _walletRepository.getAllWalletApi().then((value){
      List<dynamic> walletDataJson = value;
      List<WalletModel> transformedData = walletDataJson.map((e)=> WalletModel.fromJson(e)).toList();
      setWalletData(ApiResponse.completed(transformedData));
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}