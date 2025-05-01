// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  // static const baseUrl = 'http://10.60.129.161:3222/api';
  static const baseUrl = 'http://192.168.2.2:3222/api';

  static const loginEndPint = baseUrl + '/auth/login';

  static const registerApiEndPoint = baseUrl + '/auth/register';
  static const logoutApiEndPoint = baseUrl + '/auth/logout';

  static const changePasswordEndPoint = baseUrl + '/users/change-password';

  static const getIconCategories = baseUrl + '/transactions/transaction-type-categories';
  static const createIconCategories = baseUrl + '/transactions/transaction-type-category';
  static const transaction = baseUrl + '/transactions/transaction';
  // GET : '${AppUrl.transaction}?from=__&to=__&money_account_id=__';
  static const getIconWalletType = baseUrl + '/admins/money-account-types';
  static const wallet = baseUrl + '/money-accounts/money-account';

  static const externalBank = 'https://api.vietqr.io/v2/banks';

  static const budget = baseUrl + '/budgets/budget';

  static const aiUrl = 'http://192.168.2.2:8002/api/v1/invoice/extract';

}