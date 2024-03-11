import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

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

// Dark Theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.scaffoldBgColor,
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.scaffoldBgColor,
      // elevation: 2,
      selectedIconTheme: const IconThemeData(color: AppColors.primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
      selectedLabelStyle: GoogleFonts.robotoFlex(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.robotoFlex(fontStyle: FontStyle.italic),
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      showSelectedLabels: true,
      showUnselectedLabels: true),
  textTheme: TextTheme(
    headlineMedium: const TextStyle(
        color: AppColors.fontColor, fontWeight: FontWeight.bold),
    bodySmall: const TextStyle(
      color: AppColors.fontColor,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
    ),
    titleMedium: GoogleFonts.cuteFont(
      fontWeight: FontWeight.bold,
      fontSize: 27,
      // fontStyle: FontStyle.italic
    ),
    titleSmall: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: AppColors.smallTitleColor,
    ),
    displaySmall: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      // color: AppColors.primaryColor
    ),
    displayMedium: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      // color: AppColors.primaryColor
    ),
    displayLarge: GoogleFonts.robotoSlab(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      // color: AppColors.primaryColor
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: AppColors.inputFieldBG),
);
