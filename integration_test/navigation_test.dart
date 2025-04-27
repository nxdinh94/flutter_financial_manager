import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/main.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:fe_financial_manager/view_model/transaction_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Login, navigation', (){
    
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

        final loginButton = find.byKey(const ValueKey('loginButton'));
        // Nhập email và password
        await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'nguyenxuandinh336@gmail.com');
        await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'Dinh@123');

        await tester.tap(loginButton);
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('homeTab')), findsOneWidget);

        final addWorkspaceTabButton=  find.byKey(const ValueKey('addWorkspaceTabButton'));

        await tester.tap(addWorkspaceTabButton);
        await tester.pumpAndSettle(const Duration(seconds: 2)); // đợi animation hoàn tất
        expect(find.byKey(const ValueKey('addingWorkspaceTab')), findsOneWidget);

        final pickCategory=  find.byKey(const ValueKey('pickCategory'));
        await tester.tap(pickCategory);
        await tester.pumpAndSettle(const Duration(seconds: 2));
        expect(find.byKey(const ValueKey('selectCategory')), findsOneWidget);

        // return to hometab
        final homeTab=  find.byKey(const ValueKey('homeTabButton'));
        await tester.tap(homeTab);
        await tester.pumpAndSettle(); // đợi animation hoàn tất
        expect(find.byKey(const ValueKey('homeTab')), findsOneWidget);

        final accountTabButton =  find.byKey(const ValueKey('accountTabButton'));
        await tester.tap(accountTabButton);
        await tester.pumpAndSettle(); // đợi animation hoàn tất
        expect(find.byKey(const ValueKey('accountTab')), findsOneWidget);

      }
    });
  });
  
}
