// ignore_for_file: prefer_interpolation_to_compose_strings

class AppUrl {
  static var baseUrl = 'http://192.168.2.8:3222';

  static var moviesBaseUrl =
      'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static var loginEndPint = baseUrl + '/users/login';

  static var registerApiEndPoint = baseUrl + '/api/register';

  static var moviesListEndPoint = moviesBaseUrl + 'movies_list';
}