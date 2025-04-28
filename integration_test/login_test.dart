import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/main.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:fe_financial_manager/view_model/budget_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Login', (){
    testWidgets('Login', (WidgetTester tester)async{
      await setupLocator();
      final prefs = locator<SharedPreferences>();
      int? mode = prefs.getInt('mode');
      if (mode == null) {
        prefs.setInt('mode', 0);
      }
      final isLoggedIn = AuthManager.isLogin();
      final initialRoute = isLoggedIn ? RoutesName.homePath : RoutesName.homeAuthPath;
      CustomNavigationHelper(initialRoute);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>AuthViewModel()),
            ChangeNotifierProvider(create: (_) => ThemeManager()),
            ChangeNotifierProvider(create: (_)=> AppViewModel()),
            ChangeNotifierProvider(create: (_)=> WalletViewModel()),
            ChangeNotifierProvider(create: (_)=> TransactionViewModel()),
            ChangeNotifierProvider(create: (_)=> BudgetViewModel()),

          ],
          child: MyApp(router: CustomNavigationHelper.router),
        ),
      );
      await tester.pumpAndSettle();
      if(!isLoggedIn){
        expect(find.byKey(const ValueKey('homeAuth')), findsOneWidget);
        // Tìm và nhấn nút chuyển tab Account
        await tester.tap(find.byKey(const ValueKey('toSignInScreen')));
        await tester.pumpAndSettle(); // đợi animation hoàn tất
        expect(find.byKey(const ValueKey('signIn')), findsOneWidget);

        // Nhập email và password
        await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'nguyenxuandinh336@gmail.com');
        await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'Dinh@1234');


        final loginButton = find.byKey(const ValueKey('loginButton'));
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('homeTab')), findsOneWidget);
      }
    });
  });
  
}
