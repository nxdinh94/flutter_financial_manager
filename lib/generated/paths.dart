

import 'package:fe_financial_manager/utils/routes/routes_name.dart';

class FinalRoutes {
  static const String allWalletsPath = '${RoutesName.homePath}/${RoutesName.allWalletsPath}';
  static const String addingWorkSpacePath = RoutesName.addingWorkSpacePath;
  static const String aiResultPath = '${RoutesName.addingWorkSpacePath}/${RoutesName.aiResultPath}';
  static const String addWalletsPath = RoutesName.addWalletsPath;
  static const String accountSettingsPath = '${RoutesName.accountPath}/${RoutesName.accountSettingsPath}';
  static const String allCategoryPath = '${RoutesName.accountPath}/${RoutesName.allCategoryPath}';
  static const String homePath = RoutesName.homePath;
  static const String transactionHistoryDetailPath = '${RoutesName.homePath}/${RoutesName.transactionHistoryDetailPath}';
  static const String transactionHistoryDetailByWalletPath = '${RoutesName.walletPath}/${RoutesName.transactionHistoryDetailPath}';
  static const String walletPath = RoutesName.walletPath;
  static const String chooseRangeTimeToShowTransactionPath = '${RoutesName.walletPath}/${RoutesName.chooseRangeTimeToShowTransactionPath}';

  static const String pickExternalBankPath = '${RoutesName.addWalletsPath}/${RoutesName.pickExternalBankPath}';
  static const String pickWalletTypePath = '${RoutesName.addWalletsPath}/${RoutesName.pickWalletTypePath}';
  static const String createEventPath = '${RoutesName.accountPath}/${RoutesName.createEventPath}';
  static const String changePasswordPath = RoutesName.changePasswordPath ;
  static const String createNewCategoryPath = RoutesName.addNewCategoryPath ;
  static const String signUpPath = '${RoutesName.homeAuthPath}/${RoutesName.signUpPath}';
  static const String signInPath = '${RoutesName.homeAuthPath}/${RoutesName.signInPath}';
  static const String forgotPasswordPath = '${RoutesName.homeAuthPath}/${RoutesName.forgotPasswordPath}';
  static const String createUpdateBudgetPath = '${RoutesName.budgetsPath}/${RoutesName.createUpdateBudgetPath}';
  static const String pickCategoryPath = '${RoutesName.addingWorkSpacePath}/${RoutesName.pickCategoryPath}';
  static const String selectWalletPath = '${RoutesName.addingWorkSpacePath}/${RoutesName.selectWalletPath}';
  static const String eventPath = '${RoutesName.accountPath}/${RoutesName.eventPath}';
  static const String editCategoryPath = '${RoutesName.accountPath}/${RoutesName.editCategoryPath}';
  static const String addNotePath = '${RoutesName.addingWorkSpacePath}/${RoutesName.addNotePath}';
  static const String budgetDetailPath = '${RoutesName.budgetsPath}/${RoutesName.budgetDetailPath}';
  static const String homeAuthPath = RoutesName.homeAuthPath;
  static const String selectParentCategories = '$editCategoryPath/${RoutesName.selectParentCategoriesPath}';
  static const String pickIconPathForCategoryPath = '$editCategoryPath/${RoutesName.pickIconPathForCategoryPath}';
  static const String summaryDetailPath = '${RoutesName.homePath}/${RoutesName.summaryDetailPath}';
  static const String groupTransactionDetailPath = '${RoutesName.homePath}/${RoutesName.summaryDetailPath}/${RoutesName.groupTransactionDetailPath}';
  static const String something = '';

}