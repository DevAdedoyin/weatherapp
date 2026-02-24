import 'package:riverpod/riverpod.dart';
import 'package:weatherapp/src/features/weather/domain/air_quality_model/air_quality_model.dart';

import '../datasources/air_quality_api.dart';

final airQualityProvider = FutureProvider<AirQualityResponse?>((ref) async {
  return fetchAirQuality();
});
