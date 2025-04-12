import 'package:fe_financial_manager/view/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  testWidgets('Login test', (tester)async{
    await tester.pumpWidget(
      Signin()
    );
  });
}