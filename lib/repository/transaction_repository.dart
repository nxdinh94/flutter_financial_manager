
import 'package:fe_financial_manager/constants/app_url.dart';
import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';

class TransactionRepository{
  final BaseApiServices _baseApiServices = NetworkApiService();

  Future<dynamic> addTransaction (Map<String, dynamic> data)async{
    try{
      final dynamic response = await _baseApiServices.getPostApiResponse(AppUrl.transaction, data, true);
      return response;
    }catch(e){
      rethrow;
    }
  }
  // Data include {fromDate, toDate, walletId}
  Future<dynamic> getTransaction (Map<String, dynamic> data)async{
    try{
      // final String api = '${AppUrl.transaction}?from=${data['fromDate']}&to=${data['toDate']}&walletId=${data['walletId']}';
      final String api = '${AppUrl.transaction}?from=${data['fromDate']}&to=${data['toDate']}&walletId=${data['walletId']}';
      final dynamic response = await _baseApiServices.getGetApiResponse(api, true);
      return response['data'];
    }catch(e){
      rethrow;
    }
  }



}