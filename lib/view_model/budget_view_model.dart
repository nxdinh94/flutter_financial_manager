import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/repository/budget_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BudgetViewModel extends ChangeNotifier {

  final BudgetRepository _budgetRepository = BudgetRepository();


  ApiResponse<List<dynamic>> _allBudgetsData = ApiResponse.loading();
  ApiResponse<List<dynamic>> get allBudgetsData => _allBudgetsData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  void setAllBudgetsData(ApiResponse<List<dynamic>> value) {
    _allBudgetsData = value;
    notifyListeners();
  }

  Future<void> getAllBudgets(BuildContext context) async {
    setLoading = true;
    try {
      await _budgetRepository.getAllBudgets().then((value) {
        setAllBudgetsData(ApiResponse.completed(value));
        setLoading = false;
      });
    } catch (e) {
      print(e);
      Utils.flushBarErrorMessage('Something went wrong!!!', context);
    } finally {
      setLoading = false;
    }
  }

  Future <void> updateBudget(Map<String, dynamic> data, BuildContext context) async {
    setLoading = true;
    try {
      await _budgetRepository.updateBudget(data).then((v){
        Utils.toastMessage('Update budget successfully');
        context..pop(true)..pop();
        setLoading = false;
      });

    } catch (e) {
      print('object');
      Utils.flushBarErrorMessage('Something went wrong!!!', context);
    } finally {
      setLoading = false;
    }
  }
  // delete budget
  Future<void> deleteBudget(String id, BuildContext context) async {
    setLoading = true;
    try {
      await _budgetRepository.deleteBudget(id).then((v){
        Utils.toastMessage('Delete budget successfully');
        context..pop(true)..pop();
        setLoading = false;
      });
    } catch (e) {
      Utils.flushBarErrorMessage('Something went wrong!!!', context);
    } finally {
      setLoading = false;
    }
  }


  Future<void> createBudget(Map<String, dynamic> data, BuildContext context) async {
    setLoading = true;
    try {
      await _budgetRepository.createBudget(data).then((v)async{
        await getAllBudgets(context);
        Utils.toastMessage('Create budget successfully');
        context.pop();
        setLoading = false;
      });
    } catch (e) {
      Utils.flushBarErrorMessage('Something went wrong!!!', context);
    } finally {
      setLoading = false;
    }
  }

}