// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  // static const ipv4 = 'http://10.10.23.113:';9-
  static const ipv4 = 'http://192.168.2.5:';
  static const baseUrl = '${ipv4}3222/api';
  static const invoiceAIUrl = 'https://f835-104-199-194-46.ngrok-free.app/upload';
  static const chatWithAIUrl = 'https://f835-104-19194-46.ngrok-free.app/aichat';

  // static const aiUrl = 'http://192.168.2.2:8002/api/v1/invoice/extract';

  static const loginEndPint = baseUrl + '/auth/login';
  static const loginWithGoogle = baseUrl + '/auth/google';

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
  static const personalization = baseUrl + '/users/personalization';
  static const personalizationDataChatbot = baseUrl + '/users/personalization/data-chatbot';
  static const personalizationStatus = baseUrl + '/users/personalization/status';

}