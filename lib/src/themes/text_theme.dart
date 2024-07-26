import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  // LIGHT Mode Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),

    // title theme
    titleLarge: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),

    // label theme
    bodyLarge: const TextStyle().copyWith(
        fontSize: 18.5, fontWeight: FontWeight.bold, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 15.5, fontWeight: FontWeight.w400, color: Colors.black),

    // label theme
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

  // DARK Mode Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),

    // title theme
    titleLarge: const TextStyle().copyWith(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),

    // label theme
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),

    // label theme
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}