
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
    outlineBorder: BorderSide(color: Colors.grey.shade800),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade800),
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
    appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.black87
    )

);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: const Color(0xff32B849),
    onPrimary: Colors.white,
    secondary: const Color(0xffF7F7F7),
    onSecondary: const Color(0xff32B849),
    tertiary: Colors.grey[400],
    error: const Color(0xffb00020),
    onError: Colors.white,
    surface: const Color(0xffFFFFFF), //backround
    onSurface: const Color(0xff1C1C1C), //font color on background

  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: colorTextBlack,
      fontSize: extraBigger,
      fontWeight: FontWeight.w500,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      color: colorTextBlack,
      fontSize: bigger,
      height: 1.2,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontSize: big,
      color: colorTextBlack,
      fontWeight: FontWeight.w500,
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
      fontSize: normal,  color: colorTextBlack,
      height: 1.2,
      fontFamily: 'Roboto',
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
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
    outlineBorder: BorderSide(color: Colors.grey.shade800),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade800),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.grey.shade300),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      overlayColor: Colors.grey,
      foregroundColor: colorTextBlack,
      textStyle: TextStyle(
        fontSize: normal,
        fontFamily: 'Roboto',
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff32B849),
      foregroundColor: colorTextWhite,
      padding: const EdgeInsets.symmetric(vertical: 6),
      shadowColor: Colors.transparent,
      textStyle: TextStyle(
        fontSize: normal,
        fontFamily: 'Roboto',
      ),
    )
  ),

  // iconButtonTheme: IconButtonThemeData(
  //
  // ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        const TextStyle(
          color: colorTextLabel,
          fontSize: normal
        )
      ),
    overlayColor: WidgetStatePropertyAll(Colors.transparent),
    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
    surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
    foregroundColor: WidgetStateProperty.all(colorTextLabel),

    )
  ),
  iconTheme: const IconThemeData(
    size: 28,
    color: Colors.black87,
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
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: normal,
      fontWeight: FontWeight.w500,
      color: colorTextBlack
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade200,
    thickness: 0.9,

  )


);