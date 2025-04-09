// ignore_for_file: file_names

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, [bool isBearToken = false]);
  Future<dynamic> getPostApiResponse(String url, dynamic data, [bool isBearToken = true]);
  Future<dynamic> getPatchApiResponse(String url, dynamic data, [bool isBearToken = true]);
  Future<dynamic> getDeleteApiResponse(String url, [bool isBearToken = true]);
}