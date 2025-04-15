
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
  Future<dynamic> updateTransaction (Map<String, dynamic> data)async{
    try{
      final dynamic response = await _baseApiServices.getPatchApiResponse(AppUrl.transaction, data);
      return response;
    }catch(e){
      rethrow;
    }
  }
  Future<dynamic> deleteTransaction (String transactionId)async{
    try{
      String api = '${AppUrl.transaction}/$transactionId';
      final dynamic response = await _baseApiServices.getDeleteApiResponse(api);
      return response;
    }catch(e){
      rethrow;
    }
  }
  // Data include {fromDate, toDate, money_account_id}
  Future<dynamic> getTransaction (Map<String, dynamic> data)async{

    try{
      String api = AppUrl.transaction;

      if(data['from'] != null && data['from'] != '' ){
        if(data['moneyAccountId'] == null || data['moneyAccountId'] == ''){
          api = '${AppUrl.transaction}?from=${data['from']}&to=${data['to']}';
        }else {
          api = '${AppUrl.transaction}?from=${data['from']}&to=${data['to']}&money_account_id=${data['moneyAccountId']}';
        }
      }
      final dynamic response = await _baseApiServices.getGetApiResponse(api, true);
      return response['data'];
    }catch(e){
      rethrow;
    }
  }



}