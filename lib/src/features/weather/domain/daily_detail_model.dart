import 'package:weatherapp/src/features/weather/domain/daily_weather_model.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

class DailyDetailModel {
  final int dateTime; // Time of data forecasted
  final int sunrise; // Sunrise time
  final int sunset; // Sunset time
  final int moonrise; // Moonrise time
  final int moonset; // Moonset time
  final String summary; // Summary of the weather condition
  final Temp temp; // Temperature information
  final FeelsLike feelsLike; // "Feels like" temperature information
  final int pressure; // Atmospheric pressure
  final int humidity; // Humidity percentage
  final double dewPoint; // Dew point temperature
  final double windSpeed; // Wind speed
  final int windDegree; // Wind degree
  final SubWeather weather; // Detailed weather information

  // Constructor for the DailyWeatherModel class
  DailyDetailModel({
    required this.dateTime,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.moonrise,
    required this.moonset,
    required this.summary,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDegree,
    required this.weather,
  });
}
