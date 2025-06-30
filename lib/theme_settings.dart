import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF00141F);
const cardColor = Color(0xFF04324A);
const richColor = Color(0xFFFF9D1D);
const lightColor = Colors.white;

ThemeData customThemeSettings = ThemeData.dark(useMaterial3: false).copyWith(
  appBarTheme: const AppBarTheme(
    foregroundColor: richColor,
    backgroundColor: backgroundColor,
    titleTextStyle: TextStyle(
      color: richColor,
      fontSize: 30.0,
    ),
  ),
  scaffoldBackgroundColor: backgroundColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: richColor,
      fontSize: 22.0,
    ),
    bodyMedium: TextStyle(
      color: richColor,
      fontSize: 22.0,
    ),
    bodySmall: TextStyle(
      color: lightColor,
      fontSize: 22.0,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: lightColor,
    titleTextStyle: TextStyle(
      fontSize: 18.0,
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(backgroundColor),
      backgroundColor: MaterialStatePropertyAll(richColor),
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          fontSize: 22.0,
        ),
      ),
    ),
  ),
  cardTheme: const CardTheme(
    color: cardColor,
    // elevation: 4.0,
    // shape: RoundedRectangleBorder(
    //   side: const BorderSide(color: richColor, width: 1.0),
    //   borderRadius: BorderRadius.circular(5.0),
    // ),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: backgroundColor,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: cardColor,
    textStyle: TextStyle(
      color: richColor,
      fontSize: 18.0,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: richColor,
    ),
    errorStyle: TextStyle(
      fontSize: 16.0,
    ),
    fillColor: cardColor,
    prefixIconColor: richColor,
    suffixIconColor: richColor,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: richColor,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: richColor,
        width: 3.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Colors.red,
        width: 3.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Colors.red,
        width: 3.0,
      ),
    ),
  ),
);
