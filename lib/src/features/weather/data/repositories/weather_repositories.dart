import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/weather/data/datasources/weather_api_datasource.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

// Create a provider for fetching weather data using the WeatherApiDataSource
final weatherDataProvider = FutureProvider<WeatherModel>((ref) async {
  return ref.watch(weatherProvider).fetchWeather();
});
