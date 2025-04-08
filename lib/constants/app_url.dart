// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  // static const baseUrl = 'http://10.60.222.22:3222/api';
  static const baseUrl = 'http://192.168.2.11:3222/api';

  static const loginEndPint = baseUrl + '/auth/login';

  static const registerApiEndPoint = baseUrl + '/auth/register';
  static const logoutApiEndPoint = baseUrl + '/auth/logout';

  static const changePasswordEndPoint = baseUrl + '/users/change-password';

  static const getIconCategories = baseUrl + '/apps/transaction-type-categories';
  static const getIconWalletType = baseUrl + '/admins/money-account-types';

  static const wallet = baseUrl + '/apps/money-account';
  static const getWalletById = baseUrl + '/apps/money-account'; // /api/apps/money-account/:id


  static const externalBank = 'https://api.vietqr.io/v2/banks';

  static const addTransaction =baseUrl +  '/apps/transaction';


}