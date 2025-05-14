
import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/repository/app_repository.dart';
import 'package:fe_financial_manager/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../model/transaction_categories_icon_model.dart';
import '../view/onboarding/onboarding.dart';

class AppViewModel extends ChangeNotifier{

  final AppRepository _appRepository = AppRepository();

  // Icon Categories
  ApiResponse _iconCategoriesData = ApiResponse.loading();
  ApiResponse get iconCategoriesData => _iconCategoriesData;

  ApiResponse _iconParentCategoriesData = ApiResponse.loading();
  ApiResponse get iconParentCategoriesData => _iconParentCategoriesData;

  ApiResponse _userPersonalizationDataForChatBot = ApiResponse.loading();
  ApiResponse get userPersonalizationDataForChatBot => _userPersonalizationDataForChatBot;

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
  void setUserPersonalizationDataForChatBot(ApiResponse value){
    _userPersonalizationDataForChatBot = value;
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
  Future<void> updateTransactionCategoriesApi(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    await _appRepository.updateIconCategoriesApi(data).then((value) async{
      Utils.toastMessage('Category updated successfully');
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> deleteTransactionCategoriesApi(String id, BuildContext context) async {
    setLoading(true);
    await _appRepository.deleteIconCategoriesApi(id).then((value) async{
      Utils.toastMessage('Category deleted successfully');
      context.pop(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  void getListOfParentExpensesCategories(List<CategoriesIconModel> data) {
    List<CategoriesIconModel> listParentCategory = [];
    for(var i in data){
      CategoriesIconModel item = CategoriesIconModel(
          id: i.id, name: i.name,
          icon: i.icon, transactionTypeId: i.transactionTypeId,
          parentId: i.parentId,
          children: []
      );

      listParentCategory.add(item);
    }
    setIconsParentCategoriesData(ApiResponse.completed(listParentCategory));
  }

  Future<void> getIconCategoriesApi() async {
    setLoading(true);

    // final sharedPref = locator<SharedPreferences>();
    // Map<String, dynamic> iconCategoriesCachedData = jsonDecode(sharedPref.getString('iconCategoriesData') ?? '{}');
    // if(iconCategoriesCachedData.isEmpty){
    //   print('uncached');
    await _appRepository.getIconCategoriesApi().then(( value)async {
      CategoriesIconListModel data = value;
      // convert data to json and save to shared preferences
      // await sharedPref.setString('iconCategoriesData', jsonEncode(data));
      setIconsCategoriesData(ApiResponse.completed(data));
      // Get list of parent expenses categories
      getListOfParentExpensesCategories(data.categoriesIconExpenseList!);
      getListOfIdOfExpenseCategory(data.categoriesIconExpenseList!);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
    // }else{
    //   print('cached');
    //   String  dataFromCached = sharedPref.getString('iconCategoriesData')!;
    //   dynamic decodedData = jsonDecode(dataFromCached);
    //   print(decodedData['expense'][4]['children']);
    //   CategoriesIconListModel fromJsonData = CategoriesIconListModel.fromJson(decodedData);
    //   setIconsCategoriesData(ApiResponse.completed(fromJsonData));
    //   getListOfParentExpensesCategories(fromJsonData.categoriesIconExpenseList!);
    //   getListOfIdOfExpenseCategory(fromJsonData.categoriesIconExpenseList!);
    // }
  }

  Future<void> collectUserPersonalization(Map<String, dynamic> data, BuildContext context)async{
    await _appRepository.collectUserPersonalizationApi(data).then((v){
      context.pop();
    });
  }
  Future<void> getUserPersonalizationStatus(BuildContext context)async{
    await _appRepository.getUserPersonalizationStatusApi().then((value){
      if(!value){
        showMaterialModalBottomSheet(
          context: context,
          expand: true,
          enableDrag: false,
          useRootNavigator: true,
          builder: (context) => Container(
            child: const MyPageView(),
          ),
        );
      }
    });
  }
  Future<dynamic> getUserPersonalizationDataForChatBot(BuildContext context)async{
    try{
      dynamic result = await _appRepository.getUserPersonalizationDataForChatBotApi();
      Map<String, dynamic> transformedData = {};
      List<dynamic> expenseTransactionsOfMonth = result['expense_transactions_of_month'];
      transformedData['monthlyIncome'] = result['monthly_income'];
      transformedData['totalSpendingThisMonth'] = result['total_amount_expense_of_month'];
      transformedData['spendingBreakdown'] = [
        ...expenseTransactionsOfMonth.map((e){
          return {
            'type': e['name'],
            'amount': e['amount_of_money'],
          };
        })
      ];
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }


  }

}