import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/repository/app_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/transaction_categories_icon_model.dart';
class AppViewModel extends ChangeNotifier{

  final AppRepository _appRepository = AppRepository();

  // Icon Categories
  ApiResponse _iconCategoriesData = ApiResponse.loading();
  ApiResponse get iconCategoriesData => _iconCategoriesData;

  ApiResponse _iconParentCategoriesData = ApiResponse.loading();
  ApiResponse get iconParentCategoriesData => _iconParentCategoriesData;

  List<String> _listIdOfExpenseCategory = [];
  List<String> get listIdOfExpenseCategory => _listIdOfExpenseCategory;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setIconsCategoriesData(ApiResponse value) {
    _iconCategoriesData = value;
    notifyListeners();
  }
  // List of parent categories
  void setIconsParentCategoriesData(ApiResponse value) {
    _iconParentCategoriesData = value;
    notifyListeners();
  }
  void setListOfIdOfExpenseCategory(List<String> value) {
    _listIdOfExpenseCategory = value;
    notifyListeners();
  }

  void getListOfIdOfExpenseCategory(List<CategoriesIconModel> data) {
    List<String> listId = [];
    for (CategoriesIconModel i in data) {
      listId.add(i.id);
      for(CategoriesIconModel child in i.children){
        listId.add(child.id);
      }
    }
    setListOfIdOfExpenseCategory(listId);
  }
  // create transaction categories
  Future<void> createTransactionCategoriesApi(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    await _appRepository.createIconCategoriesApi(data).then((value) async{
      Utils.toastMessage('Category created successfully');
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> getIconCategoriesApi() async {
    setLoading(true);
    await _appRepository.getIconCategoriesApi().then((value) {
      CategoriesIconListModel data = value;
      List<CategoriesIconModel> listParentCategory = [];
      setIconsCategoriesData(ApiResponse.completed(data));

      // Get list of parent categories
      for(var i in data.categoriesIconExpenseList!){
        CategoriesIconModel item = CategoriesIconModel(
          id: i.id, name: i.name,
          icon: i.icon, transactionTypeId: i.transactionTypeId,
          parentId: i.parentId,
          children: []
        );

        listParentCategory.add(item);
      }
      setIconsParentCategoriesData(ApiResponse.completed(listParentCategory));

      getListOfIdOfExpenseCategory(data.categoriesIconExpenseList!);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}