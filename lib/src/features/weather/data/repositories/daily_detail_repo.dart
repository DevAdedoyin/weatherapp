import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/weather/domain/daily_detail_model.dart';
import 'package:weatherapp/src/features/weather/domain/daily_weather_model.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

final dailyWeatherProvider = Provider<DailyDetailModel>((ref) {
  // Logic to fetch daily weather data would go here
  // For simplicity, I'm just returning some dummy data
  return DailyDetailModel(
      dateTime: "dateTime",
      temp: Temp(day: 0, eve: 0, max: 0, min: 0, morn: 0, night: 0),
      feelsLike: FeelsLike(day: 0, eve: 0, morn: 0, night: 0),
      pressure: 0,
      moonrise: 0,
      moonset: 0,
      summary: "summary",
      sunrise: 0,
      sunset: 0,
      humidity: 0,
      dewPoint: 0,
      windSpeed: 0,
      windDegree: 0,
      weather:
          SubWeather(main: "main", description: "description", icon: "icon"));
});
