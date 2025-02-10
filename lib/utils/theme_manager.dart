import 'package:fe_financial_manager/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  class ThemeManager extends ChangeNotifier{

    ThemeMode _themeMode = locator<SharedPreferences>().getInt('mode')!  == 0 ? ThemeMode.light : ThemeMode.dark;
    get themeMode => _themeMode;

    void switchMode() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      // Store in localStore
      storeChosenMode();
      notifyListeners();
    }

    void storeChosenMode(){
      int flag = 0; //light
      _themeMode == ThemeMode.light ? flag = 0: flag = 1;
      locator<SharedPreferences>().setInt('mode', flag);
    }

  }