import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';
import 'package:fe_financial_manager/constants/app_url.dart';

class WalletRepository{
  final BaseApiServices _apiServices  = NetworkApiService();

  Future<dynamic> getIconsWalletTypeDataApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getIconWalletType);
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> createWalletApi(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse( AppUrl.wallet, data, true);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getAllWalletApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.wallet, true);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getSingleWalletApi(String walletId) async {
    try {
      String api = '${AppUrl.wallet}/$walletId';
      dynamic response = await _apiServices.getGetApiResponse(api, true);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> updateWalletApi(Map<String, dynamic> data) async {
    try {
      dynamic response = await _apiServices.getPatchApiResponse(AppUrl.wallet, true);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> deleteWalletApi(String walletId) async {
    try {
      String api = '${AppUrl.wallet}/$walletId';
      dynamic response = await _apiServices.getDeleteApiResponse(api, true);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getExternalBankApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.externalBank, true);
      return response['data'];
    } catch (e) {
      rethrow;
    }
  }
}