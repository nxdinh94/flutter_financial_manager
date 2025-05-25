import 'dart:io';

import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/params_get_transaction_in_range_time.dart';
import 'package:fe_financial_manager/model/info_extracted_from_ai_model.dart';
import 'package:fe_financial_manager/model/picked_icon_model.dart';
import 'package:fe_financial_manager/model/transaction_categories_icon_model.dart';
import 'package:fe_financial_manager/model/wallet_model.dart';
import 'package:fe_financial_manager/repository/transaction_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../model/transactions_history_model.dart';
import '../utils/get_initial_data.dart';
class TransactionViewModel  extends ChangeNotifier{

  final TransactionRepository _transactionRepository = TransactionRepository();
  bool _loading = false;
  bool get loading => _loading;

  ApiResponse<Map<String, dynamic>> _transactionHistoryData = ApiResponse.loading();
  ApiResponse<Map<String, dynamic>> get transactionHistoryData => _transactionHistoryData;

  ApiResponse<Map<String, dynamic>> _transactionByWalletInRangeTime = ApiResponse.loading();
  ApiResponse<Map<String, dynamic>> get transactionByWalletInRangeTime => _transactionByWalletInRangeTime;

  ApiResponse<Map<String, dynamic>> _transactionForChart = ApiResponse.loading();
  ApiResponse<Map<String, dynamic>> get transactionForChart => _transactionForChart;

  ApiResponse<InfoExtractedFromAiModel> _infoExtractedFromAi = ApiResponse.loading();
  ApiResponse<InfoExtractedFromAiModel> get infoExtractedFromAi => _infoExtractedFromAi;


  Map<PickedIconModel, dynamic> _expenseTransactionForDetailSummary = {};
  Map<PickedIconModel, dynamic> get expenseTransactionForDetailSummary => _expenseTransactionForDetailSummary;

  Map<PickedIconModel, dynamic> _incomeTransactionForDetailSummary = {};
  Map<PickedIconModel, dynamic> get incomeTransactionForDetailSummary => _incomeTransactionForDetailSummary;

  Map<String, double> _expenseDataForPieChart = {};
  Map<String, double> get expenseDataForPieChart  => _expenseDataForPieChart;

  Map<String, double> _incomeDataForPieChart = {};
  Map<String, double> get incomeDataForPieChart => _incomeDataForPieChart;



  ParamsGetTransactionInRangeTime _paramsGetTransactionChartInRangeTime
                              = ParamsGetTransactionInRangeTime(from: '', to: '', moneyAccountId: '');
  ParamsGetTransactionInRangeTime get paramsGetTransactionChartInRangeTime => _paramsGetTransactionChartInRangeTime;

  void setParamsGetTransactionChartInRangeTime(ParamsGetTransactionInRangeTime params){
    _paramsGetTransactionChartInRangeTime = params;
    notifyListeners();
  }
  void setInfoExtractedFromAi(ApiResponse<InfoExtractedFromAiModel> data){
    _infoExtractedFromAi = data;
    notifyListeners();
  }

  void setDataForPieChart(Map<String, double> expense, Map<String, double> income){
    _expenseDataForPieChart = expense;
    _incomeDataForPieChart = income;
    notifyListeners();
  }
  void setDataForDetailSummary(
    Map<PickedIconModel, List<TransactionHistoryModel>> expenseTransaction,
    Map<PickedIconModel, List<TransactionHistoryModel>> incomeTransaction
  ){
    _expenseTransactionForDetailSummary = expenseTransaction;
    _incomeTransactionForDetailSummary = incomeTransaction;
    notifyListeners();
  }


  void setTransactionHistoryData(ApiResponse<Map<String, dynamic>> data){
    _transactionHistoryData = data;
    notifyListeners();
  }
  void setTransactionForChart(ApiResponse<Map<String, dynamic>> data){
    _transactionForChart = data;
    notifyListeners();
  }
  void setTransactionByWalletInRangeTime(ApiResponse<Map<String, dynamic>> data){
    _transactionByWalletInRangeTime = data;
    notifyListeners();
  }

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> addTransaction(Map<String, dynamic> data,Function func ,BuildContext context)async{
    setLoading(true);
    await _transactionRepository.addTransaction(data).then((value)async{
      setLoading(false);
      func();
      await context.read<WalletViewModel>().getAllWallet();
      ParamsGetTransactionInRangeTime params = context.read<TransactionViewModel>().paramsGetTransactionChartInRangeTime;
      await context.read<TransactionViewModel>().getTransactionInRangeTime(params);
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
  Future<void> deleteTransaction(String transactionId, BuildContext context)async{
    setLoading(true);
    await _transactionRepository.deleteTransaction(transactionId).then((value){
        Utils.toastMessage('Your transaction has been deleted');
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Map<String, dynamic> transformTransactionHistory(Map<String, dynamic> value){
    for(String keys in value['transactions_by_date'].keys){
      List<dynamic> listOfTransaction = value['transactions_by_date'][keys]['transactions'];
      List<TransactionHistoryModel> transformedList = [];
      for (var e in listOfTransaction) {
        transformedList.add(TransactionHistoryModel.fromJson(e));
      }
      value['transactions_by_date'][keys]['transactions'] = transformedList;
    }
    return value;
  }

  // Data include {fromDate, toDate, walletId}
  Future<void> getTransactionInRangeTime(ParamsGetTransactionInRangeTime params)async{
    setLoading(true);
    await _transactionRepository.getTransaction(params).then((value){
      // value key is {transactions_by_date, total_all_expense, total_all_income}
      // date : {transactions, total_expense, total_income}

      // transform value
      Map<String, dynamic> transformedData = transformTransactionHistory(value);
      if(params.moneyAccountId != ''){
        setTransactionByWalletInRangeTime(ApiResponse.completed(transformedData));
      }else {
        setTransactionHistoryData(ApiResponse.completed(transformedData));
      }
      setLoading(false);
    }).onError((error, stackTrace){
      if (params.moneyAccountId != '') {
        setTransactionByWalletInRangeTime(ApiResponse.error(error.toString()));
      } else {
        setTransactionHistoryData(ApiResponse.error(error.toString()));
      }
    });
  }
  Future<void> getTransactionForChart(ParamsGetTransactionInRangeTime params, BuildContext context)async{
    setLoading(true);
    await _transactionRepository.getTransaction(params).then((value){
      // value key is {transactions_by_date, total_all_expense, total_all_income}
      // date : {transactions, total_expense, total_income}
      // transform value
      Map<String, dynamic> transformedData = transformTransactionHistory(value);
      List<TransactionHistoryModel> toListOfExpenseTransaction = [];
      List<TransactionHistoryModel> toListOfIncomeTransaction = [];


      Map<String, dynamic> groupExpenseTransactionByParent = {};
      Map<String, dynamic> groupIncomeTransactionByParent = {};

      // transform transactions_by_date to list of transaction
      for(String keys in transformedData['transactions_by_date'].keys){
        List<TransactionHistoryModel> listOfTransaction = transformedData['transactions_by_date'][keys]['transactions'];
        for (var e in listOfTransaction) {
          if(e.transactionTypeCategory.transactionType.toLowerCase() == 'income'){
            // if transaction type is income, add to list of income transaction
            toListOfIncomeTransaction.add(e);
          }else {
            toListOfExpenseTransaction.add(e);
          }
        }
      }
      // group by parent category of expense transaction
      // groupExpenseTransactionByParent = {'parentId': [transaction1, transaction2]}
      for(var i in toListOfExpenseTransaction){
        String parentId = i.transactionTypeCategory.parentId;
        String id = i.transactionTypeCategory.id;
        if(parentId.isEmpty){
          // if parentId is empty, it means that this is a parent category
          // every children will be added to corresponding parent category
          // check if the parentId is already in the map, if this item is a parent category
          // then add this to the that parent category
          if(groupExpenseTransactionByParent.containsKey(id)){
            groupExpenseTransactionByParent[i.transactionTypeCategory.id].add(i);
          }else{
            groupExpenseTransactionByParent[i.transactionTypeCategory.id] = [i];
          }
        }else{
          if(groupExpenseTransactionByParent.containsKey(parentId)){
            groupExpenseTransactionByParent[parentId]!.add(i);
          }else {
            groupExpenseTransactionByParent[parentId] = [i];
          }
        }
      }
      // group by parent category of income transaction
      // groupIncomeTransactionByParent = {'parentId': [transaction1, transaction2]}
      for(var i in toListOfIncomeTransaction){
        String id = i.transactionTypeCategory.id;
        if(groupIncomeTransactionByParent.containsKey(id)){
          groupIncomeTransactionByParent[i.transactionTypeCategory.id].add(i);
        }else{
          groupIncomeTransactionByParent[i.transactionTypeCategory.id] = [i];
        }
      }
      // Transform parent key from string to TransactionHistoryModel
      List<CategoriesIconModel> listParentCategory = context.read<AppViewModel>().iconParentCategoriesData.data;
      // newGroupExpenseTransactionByParent = {'parentCategoriesIconModel': [transaction1, transaction2]}
      Map<PickedIconModel, List<TransactionHistoryModel>> newGroupExpenseTransactionByParent = {};
      for(String key in groupExpenseTransactionByParent.keys){
        for(CategoriesIconModel parentCategoryItem in listParentCategory){
          if(key == parentCategoryItem.id){
            PickedIconModel newKey = PickedIconModel(
                icon: parentCategoryItem.icon,
                name: parentCategoryItem.name,
                id: parentCategoryItem.id
            );
            newGroupExpenseTransactionByParent[newKey] = groupExpenseTransactionByParent[key];
          }
        }
      }
      Map<PickedIconModel, List<TransactionHistoryModel>> newGroupIncomeTransactionByParent = {};
      for(String key in groupIncomeTransactionByParent.keys){
        TransactionHistoryModel firstItem = groupIncomeTransactionByParent[key][0];
        PickedIconModel newKey = PickedIconModel(
          icon: firstItem.transactionTypeCategory.icon,
          name: firstItem.transactionTypeCategory.name,
          id: firstItem.transactionTypeCategory.id
        );
        Map<PickedIconModel, List<TransactionHistoryModel>> newItem = {newKey: groupIncomeTransactionByParent[key]};
        newGroupIncomeTransactionByParent.addAll(newItem);
      }

      // set expense data for pie chart
      Map<String, double> expenseDataForPieChart = {};
      for(PickedIconModel key in newGroupExpenseTransactionByParent.keys){
        double totalExpense = 0;
        for(var i in newGroupExpenseTransactionByParent[key]!){
          totalExpense += double.parse(i.amountOfMoney);
        }
        expenseDataForPieChart[key.name] = totalExpense;
      }
      // set income data for pie chart
      Map<String, double> incomeDataForPieChart = {};
      for(PickedIconModel key in newGroupIncomeTransactionByParent.keys){
        double totalIncome = 0;
        for(var i in newGroupIncomeTransactionByParent[key]!){
          totalIncome += double.parse(i.amountOfMoney);
        }
        incomeDataForPieChart[key.name] = totalIncome;
      }
      setDataForPieChart(expenseDataForPieChart, incomeDataForPieChart);
      setTransactionForChart(ApiResponse.completed(transformedData));
      setDataForDetailSummary(newGroupExpenseTransactionByParent, newGroupIncomeTransactionByParent);
      setLoading(false);
    }).onError((error, stackTrace){
      print(error);
    });
  }

  Future<void> uploadImage(BuildContext context, [bool isGotoPage = true]) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setLoading(true);
      File imageFile = File(pickedFile.path);
      String imagePath = imageFile.path;
      try {
        final value = await _transactionRepository.uploadImage(imagePath);
        Map<String, dynamic> data = value['important_info'];
        data['amount_of_money'] = data['amount_of_money'] == null
            ? '0'
            : ( double.parse(data['amount_of_money'])).truncate().toString();

        final List<WalletModel> listWalletData = context.read<WalletViewModel>().allWalletData.data ?? [];
        getInitialData((v) {
          data['wallet_type'] = {
            'money_account_type': {
              'icon': v.icon,
            },
            'id': v.id,
            'name': v.name,
          };
        }, listWalletData, context);

        final List<CategoriesIconModel> listCategoriesData = context.read<AppViewModel>().iconCategoriesData.data?.categoriesIconListMap['expense'] ?? [];
        for (CategoriesIconModel i in listCategoriesData) {
          if (i.name == data['category']) {
            data['category'] = {
              'icon': i.icon,
              'name': i.name,
              'id': i.id,
              'transaction_type': {
                'type': '',
              }
            };
            break;
          }
          for (CategoriesIconModel c in i.children) {
            if (c.name == data['category']) {
              data['category'] = {
                'icon': i.icon,
                'name': i.name,
                'id': i.id
              };
              break;
            }
          }
        }

        final InfoExtractedFromAiModel result = InfoExtractedFromAiModel.fromJson(data);
        setInfoExtractedFromAi(ApiResponse.completed(result));
        if (isGotoPage) {
          context.push(FinalRoutes.aiResultPath);
        }
      } catch (e) {
        print('Error uploading image: $e');
        Utils.flushBarErrorMessage('Unable to load image', context);
      } finally {
        setLoading(false);
      }


    } else {
      setInfoExtractedFromAi(ApiResponse.error('Unable to process'));
      Utils.flushBarErrorMessage('Unable to load image', context);
    }
  }


}