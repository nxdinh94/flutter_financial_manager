// ignore_for_file: use_rethrow_when_possible, unused_import, prefer_final_fields

import 'dart:convert';

import 'package:fe_financial_manager/utils/utils.dart';
import 'package:http/http.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/token.dart';
import '../constants/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> loginWithGoogleApi(Map<String, dynamic> idToken) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginWithGoogle, idToken);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.registerApiEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> logOutApi(dynamic refreshToken) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.logoutApiEndPoint, refreshToken, true );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changePasswordApi(Map<String, String> data) async {
    try {
      dynamic response = await _apiServices.getPatchApiResponse(
          AppUrl.changePasswordEndPoint, data, true );
      return response;
    } catch (e) {
      throw e;
    }
  }

}