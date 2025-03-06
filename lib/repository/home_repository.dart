// ignore_for_file: prefer_final_fields, use_rethrow_when_possible


import 'package:fe_financial_manager/data/network/NetworkApiService.dart';

import '../data/network/BaseApiServices.dart';
import '../model/movies_model.dart';
import '../res/app_url.dart';

class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}