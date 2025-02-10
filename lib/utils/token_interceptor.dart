import 'package:dio/dio.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';

class TokenInterceptor extends Interceptor {

  @override
  Future onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
  ) async {
    // Here you can put the token, either from preference, sqlite, etc.
    // Here is an example with Preferences
    final someToken = AuthManager.readAuth();
    // After you choose your token, you assign it to the request.
    options.headers['Authorization'] = 'Bearer $someToken';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data
    super.onResponse(response, handler);
  }

  @override
  Future onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {
      print(err.response);
    }
    super.onError(err, handler);
  }
}