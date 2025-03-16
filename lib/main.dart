
import 'package:fe_financial_manager/injection_container.dart';
import 'package:fe_financial_manager/utils/auth_manager.dart';
import 'package:fe_financial_manager/utils/routes/routes.dart';
import 'package:fe_financial_manager/utils/routes/routes_name.dart';
import 'package:fe_financial_manager/utils/theme_manager.dart';
import 'package:fe_financial_manager/view_model/app_view_model.dart';
import 'package:fe_financial_manager/view_model/auth_view_model.dart';
import 'package:fe_financial_manager/view_model/home_view_model.dart';
import 'package:fe_financial_manager/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  // setup light mode if no mode chosen
  int ? mode =  locator<SharedPreferences>().getInt('mode');
  if(mode == null){
    locator<SharedPreferences>().setInt('mode', 0);
  }
  if (AuthManager.isLogin()) {
    CustomNavigationHelper(RoutesName.homePath);
  } else {
    CustomNavigationHelper(RoutesName.homeAuthPath);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_)=> HomeViewViewModel()),
        ChangeNotifierProvider(create: (_)=> AppViewModel()),
        ChangeNotifierProvider(create: (_)=> WalletViewModel()),
      ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeManager _themeManager;
  late ThemeMode _themeMode;

  @override
  void initState() {
    _themeManager = Provider.of<ThemeManager>(context, listen: false);
    _themeMode = _themeManager.themeMode;
    _themeManager.addListener(changeThemeMode);
    super.initState();
  }
  @override
  void dispose() {
    _themeManager.removeListener(changeThemeMode);
    super.dispose();
  }
  void changeThemeMode() {
    setState(() {
      _themeMode = _themeManager.themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      routerConfig: CustomNavigationHelper.router,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('vi', ''),
      ],
      builder: (context, router) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: router!,
          ),
        );
      },
    );
  }
}