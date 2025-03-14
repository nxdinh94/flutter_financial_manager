import 'package:fe_financial_manager/repository/transaction_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/material.dart';
class TransactionViewModel  extends ChangeNotifier{

  final TransactionRepository _transactionRepository = TransactionRepository();
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value){
    _loading = loading;
    notifyListeners();
  }

  Future<void> addTransaction(Map<String, dynamic> data, BuildContext context)async{
    setLoading(true);
    await _transactionRepository.addTransaction(data).then((value){
      setLoading(false);
      Utils.toastMessage('Your transaction has been recorded');
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

}