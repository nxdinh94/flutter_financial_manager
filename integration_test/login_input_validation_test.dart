
import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/main.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
  @override
  Future<void> loginWithGoogleApi(BuildContext context) {
    // TODO: implement loginWithGoogleApi
    throw UnimplementedError();
  }
  @override
  void saveTokenAndUserInformation(value) {
    // TODO: implement saveTokenAndUserInformation
  }
}

void main() {
  group('', () {
    setUp(()async {
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
    testWidgets('Login form shows error when empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>AuthViewModel()),
            ChangeNotifierProvider(create: (_)=>ThemeManager()),

          ],
          child: MyApp(router: CustomNavigationHelper.router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('homeAuth')), findsOneWidget);

      final toSignInButton = find.byKey(const ValueKey('toSignInScreen'));
      await tester.tap(toSignInButton);
      await tester.pumpAndSettle();
      // Tìm nút login
      final loginButton = find.byKey(const ValueKey('loginButton'));
      expect(loginButton, findsOneWidget);

      // Bấm nút login khi email và password rỗng
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));


      // Kiểm tra xem có thông báo lỗi không
      expect(find.text('Email and password cannot be empty'), findsOneWidget);
      await tester.pump(const Duration(seconds: 2));

    });

    testWidgets('Login form shows invalid email message', (WidgetTester tester) async {

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>AuthViewModel()),
            ChangeNotifierProvider(create: (_)=>ThemeManager()),

          ],
          child: MyApp(router: CustomNavigationHelper.router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('homeAuth')), findsOneWidget);

      final toSignInButton = find.byKey(const ValueKey('toSignInScreen'));
      await tester.tap(toSignInButton);
      await tester.pumpAndSettle();

      // Nhập email sai và password hợp lệ
      await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'invalid_email');
      await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'validPassword');

      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pump();

      expect(find.text('Invalid email'), findsOneWidget);
    });

    testWidgets('Login form calls loginApi when valid input', (WidgetTester tester) async {
      final fakeAuth = FakeAuthViewModel();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=>AuthViewModel()),
            ChangeNotifierProvider(create: (_)=>ThemeManager()),

          ],
          child: MyApp(router: CustomNavigationHelper.router),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('homeAuth')), findsOneWidget);

      final toSignInButton = find.byKey(const ValueKey('toSignInScreen'));
      await tester.tap(toSignInButton);
      await tester.pumpAndSettle();

      // Nhập email và password hợp lệ
      await tester.enterText(find.byKey(const ValueKey('emailTextFormField')), 'nguyenxuandinh336@gmail.com');
      await tester.enterText(find.byKey(const ValueKey('passwordTextFormField')), 'Dinh@123');

      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pump();

      // Vì `loginApi` sẽ chuyển loading = true -> show LoadingOverlay
      expect(fakeAuth.loading, true);

      // Đợi hoàn thành
      await tester.pump(const Duration(milliseconds: 600));
      expect(fakeAuth.loading, false);
    });
  },);

}
