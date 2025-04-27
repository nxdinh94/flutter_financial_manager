
import 'package:fe_financial_manager/constants/app_url.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';

class BudgetRepository{

  final NetworkApiService _networkApiService = NetworkApiService();

  // Get all budgets
  Future<List<dynamic>> getAllBudgets()async{
    try{
      // Call the API to get all budgets
      final response = await _networkApiService.getGetApiResponse(AppUrl.budget, true);
      return response['data'];
    }catch(e){
      rethrow;
    }
  }

  // Update budget
  Future<void> updateBudget(Map<String, dynamic> data)async{
    try{
      // Call the API to update a budget
      final response = await _networkApiService.getPatchApiResponse(AppUrl.budget, data);
      return response;
    }catch(e){
      rethrow;
    }
  }
  // Delete budget
  Future<void> deleteBudget(String id)async{
    try{
      // Call the API to delete a budget
      String url = '${AppUrl.budget}/$id';

      final response = await _networkApiService.getDeleteApiResponse(url);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<void> createBudget (Map<String, dynamic> data)async{
    try{
      // Call the API to create a budget
      final response = await _networkApiService.getPostApiResponse(AppUrl.budget, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

}