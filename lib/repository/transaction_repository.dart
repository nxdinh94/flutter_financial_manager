
import 'package:fe_financial_manager/constants/app_url.dart';
import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';

class TransactionRepository{
  final BaseApiServices _baseApiServices = NetworkApiService();

  Future<dynamic> addTransaction (Map<String, dynamic> data)async{
    try{
      final dynamic response = await _baseApiServices.getPostApiResponse(AppUrl.addTransaction, data, true);
      return response;
    }catch(e){
      rethrow;
    }
  }
}