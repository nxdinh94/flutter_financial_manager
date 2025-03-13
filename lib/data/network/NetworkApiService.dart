import 'dart:convert';
import 'dart:io';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, [bool isBearToken = false]) async {
    String token = AuthManager.readAuth();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if(token.isNotEmpty && isBearToken){
      headers['Authorization'] = 'Bearer $token';
    }
    dynamic responseJson;
    try {
      final response =
        await http.get(
          Uri.parse(url),
          headers: headers
        ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  @override
  Future getPostApiResponse(String url, dynamic data,  [bool isBearToken = false]) async {
    String token = AuthManager.readAuth();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if(token.isNotEmpty && isBearToken){
      headers['Authorization'] = 'Bearer $token';
    }
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
  @override
  Future getPatchApiResponse(String url, dynamic data,  [bool isBearToken = false]) async {
    String token = AuthManager.readAuth();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if(token.isNotEmpty && isBearToken){
      headers['Authorization'] = 'Bearer $token';
    }
    dynamic responseJson;
    try {
      Response response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    dynamic decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    String error = '';
    if(response.statusCode != 200){
      //cause be response is {"message": "Jwt expired"}
      if(response.statusCode == 401){
        error = decodedResponse['message'];
      }else {
        error = decodedResponse['errorInfo'][0]['message'];
      }
    }

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        throw BadRequestException(error);
      case 500:

      case 404:
        throw UnauthorisedException(error);
      default :
        throw FetchDataException(error);
    }
  }
}
