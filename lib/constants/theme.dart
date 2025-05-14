
import 'package:fe_financial_manager/constants/colors.dart';
import 'package:fe_financial_manager/constants/font_size.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB0D0),
    tertiary: Colors.white,
    onPrimary: Color(0xFF5C113B),
    primaryContainer: Color(0xFF792952),
    onPrimaryContainer: Color(0xFFFFD8E6),
    secondary: Color(0xFFE1BDCA),
    onSecondary: Color(0xFF412A33),
    surface: Colors.black87
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: colorTextWhite,
      fontSize: 30,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      color: colorTextWhite,
      fontSize: extraBigger,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontSize: big,  color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: normal,  color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: tiny,
      color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: normal,
      color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: small,
      color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: tiny,
      color: colorTextWhite,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontSize: normal,
      color: colorTextLabel,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontSize: small,
      color: colorTextLabel,height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: colorTextLabel,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    outlineBorder: const BorderSide(color: Colors.transparent),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide.none
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade300)
      )
  ),
  // iconButtonTheme: IconButtonThemeData(
  //
  // ),
  iconTheme: const IconThemeData(
    size: 28,
    color: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedIconTheme: IconThemeData(
      color: Colors.white54,
    ),
    selectedIconTheme: IconThemeData(
        color: Color(0xFFF2F2F2)
    ),
    selectedItemColor: Color(0xFFF2F2F2),
    unselectedItemColor: Colors.white54,
    unselectedLabelStyle: TextStyle(color: Colors.white54, fontSize: tiny),
    selectedLabelStyle: TextStyle(color: Color(0xFFF2F2F2), fontSize: tiny),
    backgroundColor: Colors.black87,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.black87
    )

);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xffffffff),
    onPrimary: Color(0xff1C1C1C),
    secondary: secondaryColor,
    onSecondary: Color(0xffffffff),
    tertiary: Color(0xffEEEEEE),
    error: emergencyColor,
    onError: Colors.white,
    surface: Color(0xffF2F1F7), //background
    onSurface: Color(0xff1C1C1C), //font color on background
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: colorTextBlack,
      fontSize: 30,
      fontWeight: FontWeight.w600,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      color: colorTextBlack,
      fontSize: normal,
      height: 1.2,
      fontWeight: FontWeight.w600,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: small,
      color: colorTextBlack,
      fontWeight: FontWeight.w600,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontSize: big,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      fontSize: normal,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: tiny,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: normal,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: small,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: tiny,
      color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontSize: normal,
      color: colorTextLabel,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontSize: small,
      color: colorTextLabel,height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: tiny,
      color: colorTextLabel,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    outlineBorder: BorderSide.none,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
    ),

  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade300),
      // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      overlayColor: Colors.grey,
      foregroundColor: colorTextBlack,
      textStyle: const TextStyle(
        fontSize: normal,
        fontFamily: 'Roboto',
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: colorTextWhite,

      padding: const EdgeInsets.symmetric(vertical: 6),
      shadowColor: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: normal,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500
      ),
    )
  ),

  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          color: colorTextLabel,
          fontSize: normal
        )
      ),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStateProperty.all(colorTextLabel),

    )
  ),
  iconTheme: const IconThemeData(
    size: 28,
    color: Color(0xff949398),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.black87
    ),
    selectedItemColor: Colors.black87,
    unselectedItemColor: colorTextLabel,
    unselectedLabelStyle: TextStyle(color: colorTextLabel, fontSize: tiny),
    selectedLabelStyle: TextStyle(color: colorTextBlack, fontSize: tiny),
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
    centerTitle: true,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: big,
      fontWeight: FontWeight.w500,
      color: colorTextBlack
    ),
    shape: Border(bottom: BorderSide(
        color: dividerColor,
        width: 1
    )),
  ),
  dividerTheme: const DividerThemeData(
    color: dividerColor,
    thickness: 0.9,
    space: 0
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: normal,
      color: colorTextBlack,
    ),
    subtitleTextStyle:TextStyle(
      fontSize: tiny,
      color: colorTextLabel,
    ),
    iconColor: iconColor,
    dense: true,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(primaryColor),
    trackColor: WidgetStateProperty.resolveWith((states) =>
                states.contains(WidgetState.selected) ? secondaryColor : null),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    collapsedShape: Border(),
    shape: Border(),
    childrenPadding: EdgeInsets.only(left: 18),
  ),
);