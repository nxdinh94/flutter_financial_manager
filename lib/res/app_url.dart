// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  // static const baseUrl = 'http://10.60.191.229:3222/api';
  static const baseUrl = 'http://192.168.2.8:3222/api';

  static const moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static const loginEndPint = baseUrl + '/auth/login';

  static const registerApiEndPoint = baseUrl + '/auth/register';
  static const logoutApiEndPoint = baseUrl + '/auth/logout';

  static const changePasswordEndPoint = baseUrl + '/users/change-password';

  static const getIconCategories = baseUrl + '/apps/transaction-type-categories';

  static const moviesListEndPoint = moviesBaseUrl + 'movies_list';
}