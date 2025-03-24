
import 'package:flutter/material.dart';
import 'package:weatherapp/src/themes/text_theme.dart';

import 'appbar_theme.dart';
import 'elevated_button_theme.dart';
import 'icon_button_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.green[900],
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemes.lightElevatedButtonTheme,
    // appBarTheme: AppbarTheme.lightAppBarTheme,
    iconButtonTheme: IconButtonThemes.lightModeIconButton,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.green[900],
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: ElevatedButtonThemes.darkElevatedButtonTheme,
      // appBarTheme: AppbarTheme.darkAppBarTheme
  );
}