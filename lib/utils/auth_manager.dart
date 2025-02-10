

import 'package:fe_financial_manager/injection_container.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager{
  static final SharedPreferences sp = locator();
  static Future<Map<String, dynamic>> persistTokens(String accessToken, String refreshToken)async{
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    saveId(decodedToken['id']);
    await saveRefreshAndAccessToken(accessToken, refreshToken);
    return decodedToken;
  }

  static void saveId(String id) async {
    await sp.setString('userId', id);
  }

  static String getId() {
    return sp.getString('userId') ?? '';
  }

  static Future<void> saveRefreshAndAccessToken(String accessToken, String refreshToken)async{
    await sp.setString('accessToken', accessToken);
    await sp.setString('refreshToken', refreshToken);
  }

  static String readAuth (){
    return sp.getString('accessToken') ?? '';
  }
  static String readRefreshToken (){
    return sp.getString('refreshToken') ?? '';
  }
  static void logout(){
    sp.remove('accessToken');
    sp.remove('userId');
  }

  static bool isLogin (){
    String result = readAuth();
    return result.isNotEmpty;
  }

}