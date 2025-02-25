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
    dynamic responseJson;
    try {
      final response =
        await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer ${isBearToken ? 'token': token}',
          }
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
    dynamic responseJson;
    try {
      Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${isBearToken ? token: ''}',
        },  // Thêm header
        body: jsonEncode(data),  // Chuyển thành JSON
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 422:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
          throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.body.toString());
    }
  }
}
