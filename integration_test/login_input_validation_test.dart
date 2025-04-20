
import 'package:another_flushbar/flushbar.dart';
import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/main.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';
import 'package:fe_financial_manager/view/auth/signin.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuthViewModel extends ChangeNotifier implements AuthViewModel {
  bool _loading = false;
  @override
  bool get loading => _loading;

  @override
  Future<void> changePasswordApi(Map<String, String> data, BuildContext context) {
    // TODO: implement changePasswordApi
    throw UnimplementedError();
  }

  @override
  Future<void> logoutApi(refreshToken, BuildContext context) {
    // TODO: implement logoutApi
    throw UnimplementedError();
  }

  @override
  setLoading(bool value) {
    // TODO: implement setLoading
    throw UnimplementedError();
  }

  @override
  setSignUpLoading(bool value) {
    // TODO: implement setSignUpLoading
    throw UnimplementedError();
  }

  @override
  Future<void> signUpApi(data, BuildContext context) {
    // TODO: implement signUpApi
    throw UnimplementedError();
  }

  @override
  // TODO: implement signUpLoading
  bool get signUpLoading => throw UnimplementedError();

  @override
  Future<void> loginApi(data, BuildContext context) async{
    _loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500)); // giả lập api
    _loading = false;
    notifyListeners();
  }
}

void main() {
  group('', () {
    setUp(()async {
      await GetIt.instance.reset();    // 💡 thêm dòng này trước!
      await setupLocator();
      final prefs = locator<SharedPreferences>();
      int? mode = prefs.getInt('mode');
      if (mode == null) {
        prefs.setInt('mode', 0);
      }
      final isLoggedIn = AuthManager.isLogin();
      final initialRoute = isLoggedIn ? RoutesName.homePath : RoutesName.homeAuthPath;
      CustomNavigationHelper(initialRoute);

    },);

    testWidgets('Login form - Empty Input, Invalid Email, Valid Login', (WidgetTester tester) async {
      final fakeAuth = FakeAuthViewModel();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthViewModel>.value(value: fakeAuth),
            ChangeNotifierProvider(create: (_) => ThemeManager()),
          ],
          child: MyApp(router: CustomNavigationHelper.router),
        ),
      );
      await tester.pumpAndSettle();

      // 💡 Verify màn HomeAuth
      expect(find.byKey(const ValueKey('homeAuth')), findsOneWidget);

      final toSignInButton = find.byKey(const ValueKey('toSignInScreen'));
      await tester.tap(toSignInButton);
      await tester.pumpAndSettle();

      // === CASE 1: Empty Input ===
      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Email and password cannot be empty'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // === CASE 2: Invalid Email Format ===
      await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'invalid_email');
      await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'validPassword');

      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Invalid email'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // === CASE 3: Valid Input ===
      await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'nguyenxuandinh336@gmail.com');
      await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'Dinh@123');

      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pump();

      expect(fakeAuth.loading, true);
      await tester.pump(const Duration(milliseconds: 600));
      // Check loading = false sau khi login xong
      expect(fakeAuth.loading, false);
    });
  },);

}
