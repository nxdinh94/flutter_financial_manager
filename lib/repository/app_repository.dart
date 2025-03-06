import 'package:fe_financial_manager/data/network/BaseApiServices.dart';
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';
import 'package:fe_financial_manager/model/categories_icon_model.dart';
import 'package:fe_financial_manager/res/app_url.dart';

class AppRepository{
  BaseApiServices _apiServices  = NetworkApiService();

  Future<dynamic> getIconCategoriesApi() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getIconCategories, true);
      return CategoriesIconListModel.fromJson(response['data']) ;
    } catch (e) {
      throw e;
    }
  }
}