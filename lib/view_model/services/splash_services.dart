// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/token.dart';
import '../../utils/routes/routes_name.dart';

class SplashServices {
  // Future<Token> getUserDate() => UserViewModel().readAuth();

  // void checkAuthentication(BuildContext context) async {
  //   getUserDate().then((value) async {
  //     print(value.token.toString());
  //
  //     if (value.token.toString() == 'null' || value.token.toString() == '') {
  //       await Future.delayed(Duration(seconds: 3));
  //       Navigator.pushNamed(context, RoutesName.login);
  //     } else {
  //       await Future.delayed(Duration(seconds: 3));
  //       Navigator.pushNamed(context, RoutesName.home);
  //     }
  //   }).onError((error, stackTrace) {
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }
}