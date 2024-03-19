import 'package:riverpod/riverpod.dart';

final openWeatherDetails = StateProvider<bool>((ref) => false);

final hourlyWeatherDetails = StateProvider((ref) => {"image": "", "": ""});
