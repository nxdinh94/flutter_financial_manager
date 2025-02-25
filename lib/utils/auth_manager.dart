

import 'dart:convert';

import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager{
  static final SharedPreferences sp = locator();
  static Future<Map<String, dynamic>> persistTokens(String accessToken, String refreshToken, UserModel user)async{
    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
    saveUser(user);
    await saveRefreshAndAccessToken(accessToken, refreshToken);
    return decodedToken;
  }

  static void saveUser(UserModel user) async {
    String encodedUser = jsonEncode(user);
    await sp.setString('user', encodedUser);
  }

  static UserModel getUser() {
    Map<String, dynamic> user = jsonDecode(sp.getString('user')!);
    return UserModel.fromJson(user);
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
    sp.remove('user');
  }

  static bool isLogin (){
    String result = readAuth();
    return result.isNotEmpty;
  }

}