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
      throw e;
    }
  }

}