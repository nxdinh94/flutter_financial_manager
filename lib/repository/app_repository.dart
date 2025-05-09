import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';
import 'package:fe_financial_manager/model/transaction_categories_icon_model.dart';
import 'package:fe_financial_manager/constants/app_url.dart';

class AppRepository{
  final BaseApiServices _apiServices  = NetworkApiService();

  Future<dynamic> getIconCategoriesApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getIconCategories, true);
      return CategoriesIconListModel.fromJson(response['data']) ;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> createIconCategoriesApi(Map<String, dynamic> data) async {
    try {
      await _apiServices.getPostApiResponse(AppUrl.createIconCategories, data);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> updateIconCategoriesApi(Map<String, dynamic> data) async {
    try {
      await _apiServices.getPatchApiResponse(AppUrl.createIconCategories, data);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteIconCategoriesApi(String id) async {
    try {
      String api = "${AppUrl.createIconCategories}/$id";
      await _apiServices.getDeleteApiResponse(api);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> collectUserPersonalizationApi(Map<String, dynamic> data) async {
    try {
      await _apiServices.getPostApiResponse(AppUrl.personalization, data);
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getUserPersonalizationStatusApi() async {
    try {
      dynamic result = await _apiServices.getGetApiResponse(AppUrl.personalizationStatus, true);
      return result['data'];
    } catch (e) {
      rethrow;
    }
  }
  Future<dynamic> getUserPersonalizationDataForChatBotApi() async {
    try {
      dynamic result = await _apiServices.getGetApiResponse(AppUrl.personalizationDataChatbot, true);
      return result['data'];
    } catch (e) {
      rethrow;
    }
  }
}