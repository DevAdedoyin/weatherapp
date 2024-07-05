import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
      (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> _saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', themeIndex);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      _saveTheme(2);
    } else {
      state = ThemeMode.light;
      _saveTheme(1);
    }
  }
}