
import 'dart:convert';
import 'package:fe_financial_manager/constants/app_url.dart';
import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:http/http.dart' as http;
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
  Future<dynamic> getTransaction (ParamsGetTransactionInRangeTime params)async{

    try{
      String api = AppUrl.transaction;

      if(params.from != '' && params.to != ''){
        if(params.moneyAccountId == ''){
          api = '${AppUrl.transaction}?from=${params.from}&to=${params.to}';
        }else {
          api = '${AppUrl.transaction}?from=${params.from}&to=${params.to}&money_account_id=${params.moneyAccountId}';
        }
      }else {
        if(params.moneyAccountId != ''){
          api = '${AppUrl.transaction}?money_account_id=${params.moneyAccountId}';
        }
      }
      final dynamic response = await _baseApiServices.getGetApiResponse(api, true);
      return response['data'];
    }catch(e){
      rethrow;
    }
  }
  Future<dynamic> uploadImage(String imagePath) async {

      var request = http.MultipartRequest('POST',Uri.parse(AppUrl.invoiceAIUrl));
      // Gửi file với key là 'image'
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',   // key trùng với server yêu cầu
          imagePath,
        ),
      );

      var response = await request.send();
      try {
        if (response.statusCode == 200) {
          final respStr = await response.stream.bytesToString();
          return jsonDecode(respStr);
        } else {
          throw Exception('Failed to process: ${response.statusCode}');
        }
      } catch (e) {
        rethrow;
      }
  }




}