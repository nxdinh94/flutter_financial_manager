import 'package:fe_financial_manager/view/auth/signup.dart';
import 'package:fe_financial_manager/view_model/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';

void main() {
  testWidgets('Sign Up Screen should display correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => ThemeManager()),
          ChangeNotifierProvider(create: (_) => AppViewModel()),
          ChangeNotifierProvider(create: (_) => WalletViewModel()),
          ChangeNotifierProvider(create: (_) => TransactionViewModel()),
          ChangeNotifierProvider(create: (_)=> BudgetViewModel()),

        ],
        child: MaterialApp(
          home: Signup(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final signUpScreenFinder = find.text('Sign up');

    expect(signUpScreenFinder, findsOneWidget);
  });
}
