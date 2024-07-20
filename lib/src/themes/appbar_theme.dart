import 'package:flutter/material.dart';

class AppbarTheme {
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    // backgroundColor: ,
    // backgroundColor: AppColors.primaryColors,
    // backgroundColor: Colors.transparent,
    // surfaceTintColor: Colors.transparent,
    // iconTheme: IconThemeData(color: Colors.black, size: 24, ),
    // actionsIconTheme: IconThemeData(color: Colors.red, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

  // Dark AppBar Theme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}