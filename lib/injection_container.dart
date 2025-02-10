import 'package:dio/dio.dart';
import 'package:fe_financial_manager/utils/token_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator ()async{
  // Dio
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor()); // Add this code
  locator.registerLazySingleton(() => dio);

  locator.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  // locator.registerSingleton<ProductServices>(ProductServices(locator()));




}