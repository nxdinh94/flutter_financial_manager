import 'package:fe_financial_manager/generated/paths.dart';
import 'package:fe_financial_manager/model/user_model.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/sign_in_with_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../repository/auth_repository.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _myRepo = AuthRepository();
  final SignInWithGoogle _signInWithGoogle = SignInWithGoogle();


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

  void saveTokenAndUserInformation(dynamic value){
    String accessToken = value['data']['accessToken'];
    String refreshToken = value['data']['refreshToken'];
    final UserModel user = UserModel.fromJson(value['data']['user']);
    AuthManager.persistTokens(accessToken, refreshToken, user);
  }

  Future<void> loginApi(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginApi(data).then((value) {
      saveTokenAndUserInformation(value);
      setLoading(false);
      context.pushReplacement(FinalRoutes.homePath);

    }).onError((error, stackTrace) {
      setLoading(false);
      print('======${error.toString()}');
      if (kDebugMode) {
        Utils.flushBarErrorMessage('Email or password is not correct', context);
        print(error.toString());
      }
    });
  }
  Future<void> loginWithGoogleApi(BuildContext context) async {
    final GoogleSignInAccount? user = await _signInWithGoogle.googleSignIn.signIn();
    if (user == null) return;

    final GoogleSignInAuthentication auth = await user.authentication;

    final String? idToken = auth.idToken;

    if(idToken == null){
      throw Exception('idToken is null');
    }
    setLoading(true);
    Map<String, dynamic> data = {
      'idToken': idToken,
    };
    await _myRepo.loginWithGoogleApi(data).then((value) {
      setLoading(false);
      saveTokenAndUserInformation(value);
      context.pushReplacement(FinalRoutes.homePath);
    }).onError((error, stackTrace) {
      setLoading(false);
      print('======${error.toString()}');
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
      context.push(FinalRoutes.signInPath);
    }).onError((error, stackTrace) {
      print(error);
      // Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  Future<void> logoutApi (dynamic refreshToken, BuildContext context)async{
    AuthManager.logout();
    _signInWithGoogle.googleSignIn.disconnect();

    setLoading(true);
    _myRepo.logOutApi(refreshToken).then((value){
      context.pushReplacement(FinalRoutes.homeAuthPath);
      setLoading(false);

      Utils.toastMessage('Logout Successfully');
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    });
  }

  Future<void> changePasswordApi (Map<String, String> data, BuildContext context)async{
    setLoading(true);
    _myRepo.changePasswordApi(data).then((value){
      Utils.toastMessage(value.toString());
      context.pop();
      setLoading(false);
    }).onError((error, stackTrace){
      Utils.flushBarErrorMessage('Old password is not correct', context);
      print(error);
    });
  }
}