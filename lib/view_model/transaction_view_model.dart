import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/repository/transaction_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/transactions_history_model.dart';
class TransactionViewModel  extends ChangeNotifier{

  final TransactionRepository _transactionRepository = TransactionRepository();
  bool _loading = false;
  bool get loading => _loading;

  ApiResponse<Map<String, dynamic>> _transactionHistoryData = ApiResponse.loading();
  ApiResponse<Map<String, dynamic>> get transactionHistoryData => _transactionHistoryData;

  ApiResponse<Map<String, dynamic>> _transactionByWalletInRangeTime = ApiResponse.loading();
  ApiResponse<Map<String, dynamic>> get transactionByWalletInRangeTime => _transactionByWalletInRangeTime;

  void setTransactionHistoryData(ApiResponse<Map<String, dynamic>> data){
    _transactionHistoryData = data;
    notifyListeners();
  }
  void setTransactionByWalletInRangeTime(ApiResponse<Map<String, dynamic>> data){
    _transactionByWalletInRangeTime = data;
    notifyListeners();
  }

  void setLoading(bool value){
    _loading = loading;
    notifyListeners();
  }

  Future<void> addTransaction(Map<String, dynamic> data,Function resetDataAfterSaveTransaction ,BuildContext context)async{
    setLoading(true);
    await _transactionRepository.addTransaction(data).then((value){
      setLoading(false);
      resetDataAfterSaveTransaction();
      Utils.toastMessage('Your transaction has been recorded');
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
  Future<void> updateTransaction(Map<String, dynamic> data, BuildContext context)async{
    setLoading(true);
    await _transactionRepository.updateTransaction(data).then((value){
      Utils.toastMessage('Your transaction has been updated');
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  // Data include {fromDate, toDate, walletId}
  Future<void> getTransactionInRangeTime(Map<String, dynamic> rangeTime)async{
    setLoading(true);
    await _transactionRepository.getTransaction(rangeTime).then((value){
      // value key is {transactions_by_date, total_all_expense, total_all_income}
      // date : {transactions, total_expense, total_income}

      // transform value
      for(String keys in value['transactions_by_date'].keys){
        List<dynamic> listOfTransaction = value['transactions_by_date'][keys]['transactions'];
        List<TransactionHistoryModel> transformedList = [];
        for (var e in listOfTransaction) {
          transformedList.add(TransactionHistoryModel.fromJson(e));
        }
        value['transactions_by_date'][keys]['transactions'] = transformedList;
      }

      if(rangeTime['money_account_id'] != ''){
        setTransactionByWalletInRangeTime(ApiResponse.completed(value));
      }else {
        setTransactionHistoryData(ApiResponse.completed(value));
      }
      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
    });
  }

}