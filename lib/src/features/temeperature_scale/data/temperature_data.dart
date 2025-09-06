import 'package:shared_preferences/shared_preferences.dart';

enum TempUnit { celsius, fahrenheit, kelvin }

class TemperatureConverter {
  static const _prefKey = "temp_unit";

  static Future<void> saveUnit(TempUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefKey, unit.index);
  }

  static Future<TempUnit> loadUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_prefKey) ?? 0;
    return TempUnit.values[index];
  }

  static String convert(double temperature, TempUnit unit) {
    switch (unit) {
      case TempUnit.celsius:
        return "${temperature.round()}°C";
      case TempUnit.fahrenheit:
        final f = (temperature * 9 / 5) + 32;
        return "${f.round()}°F";
      case TempUnit.kelvin:
        final k = temperature + 273.15;
        return "${k.round()}K";
    }
  }

  static Future<String> formatWithPrefs(double celsius) async {
    final unit = await loadUnit();
    return convert(celsius, unit);
  }
}
