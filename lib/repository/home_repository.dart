// ignore_for_file: prefer_final_fields, use_rethrow_when_possible
import 'package:fe_financial_manager/data/network/NetworkApiService.dart';
import '../data/network/BaseApiServices.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();
}