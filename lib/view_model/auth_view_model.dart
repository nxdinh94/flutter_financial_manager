import 'package:fe_financial_manager/data/response/api_response.dart';
import 'package:fe_financial_manager/model/user_model.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../respository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      String accessToken = value['data']['accessToken'];
      String refreshToken = value['data']['refreshToken'];
      final UserModel user = UserModel.fromJson(value['data']['user']);
      //Persist user's tokens;
      AuthManager.persistTokens(accessToken, refreshToken, user);
      setLoading(false);
      // Utils.flushBarErrorMessage(value['message'], context);
      context.pushReplacement(RoutesName.homePath);

    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage('Email or password is not correct', context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('SignUp Successfully', context);
      context.push('${RoutesName.homeAuthPath}/${RoutesName.signInPath}');
    }).onError((error, stackTrace) {
      print(error);
      // Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> logoutApi (dynamic refreshToken, BuildContext context)async{
    setLoading(false);
    _myRepo.logOutApi(refreshToken).then((value){
      print(AuthManager.readAuth());
      AuthManager.logout();
      setLoading(true);
      context.pushReplacement('${RoutesName.homeAuthPath}');

      Utils.toastMessage('Logout Successfully');
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    });
  }
  Future<void> changePasswordApi (Map<String, String> data, BuildContext context)async{
    setLoading(false);
    _myRepo.changePasswordApi(data).then((value){
      setLoading(true);
      Utils.toastMessage(value.toString());
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage('Old password is not correct', context);
      print(error);
    });
  }
}