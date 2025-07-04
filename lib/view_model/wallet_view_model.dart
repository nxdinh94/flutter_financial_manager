
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/model/external_bank_model.dart';
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

  //External Bank
  ApiResponse _externalBankData = ApiResponse.loading();
  ApiResponse get externalBankData => _externalBankData ;

  // Wallet by Id
  ApiResponse _singleWalletData = ApiResponse.loading();
  ApiResponse get singleWalletData => _singleWalletData;

  // List of id of wallet
  List<String> _listOfIdOfWallet = [];
  List<String> get listOfIdOfWallet => _listOfIdOfWallet;

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
  // Set all wallet data
  void setWalletData(ApiResponse<List<WalletModel>> value) {
    _allWalletData = value;
    notifyListeners();
  }
  // Set wallet by id data
  void setSingleWalletData(ApiResponse<SingleWalletModel> value) {
    _singleWalletData = value;
    notifyListeners();
  }
  void setExternalBankData(ApiResponse<List<ExternalBankModel>> value) {
    _externalBankData = value;
    notifyListeners();
  }
  void setListOfIdOfExpenseCategory(List<String> value) {
    _listOfIdOfWallet = value;
    notifyListeners();
  }
  void getListOfIdOfWallet(List<WalletModel> data) {
    List<String> listId = [];
    for (WalletModel i in data) {
      listId.add(i.id);
    }
    setListOfIdOfExpenseCategory(listId);

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
      context.pop(true);
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> getAllWallet()async{
    setLoading(false);
    await _walletRepository.getAllWalletApi().then((value){
      print(value);
      List<dynamic> walletDataJson = value;
      List<WalletModel> transformedData = walletDataJson.map((e)=> WalletModel.fromJson(e)).toList();
      setWalletData(ApiResponse.completed(transformedData));
      getListOfIdOfWallet(transformedData);
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> getSingleWallet(String walletId)async{
    setLoading(false);
    await _walletRepository.getSingleWalletApi(walletId).then((value){
      SingleWalletModel transformedData = SingleWalletModel.fromJson(value);
      setSingleWalletData(ApiResponse.completed(transformedData));
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> deleteWallet(String walletId)async{
    setLoading(false);
    await _walletRepository.deleteWalletApi(walletId).then((value){
      Utils.toastMessage('Delete wallet successfully');
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
      });
  }
  Future<void> updateWallet(Map<String, dynamic> data, BuildContext context)async{
    setLoading(true);
    await _walletRepository.updateWalletApi(data).then((message){
      // backend return message
      Utils.toastMessage(message);
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> getExternalBank()async{
    setLoading(false);
    await _walletRepository.getExternalBankApi().then((value){
      List<dynamic> externalBank = value;
      List<ExternalBankModel> transformedData = externalBank.map((e)=> ExternalBankModel.fromJson(e)).toList();
      setExternalBankData(ApiResponse.completed(transformedData));
      setLoading(true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}