import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all<Color>(AppColors.secondaryColor),
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium:
        TextStyle(color: AppColors.fontColor, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
      color: AppColors.fontColor,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: AppColors.inputFieldBG),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
