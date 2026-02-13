import 'package:riverpod/riverpod.dart';

final airQualityColor = StateProvider<Map<String, double>>(
    (ref) => {"red": 1.0, "green": 1.0, "blue": 1.0});
