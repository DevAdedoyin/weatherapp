import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

class HourlyWeatherModel {
  final int dateTime;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDegree;
  final double windGust;
  final int visibility;
  final SubWeather weather;

  // Constructor for HourlyWeatherModel
  HourlyWeatherModel(
      {required this.dateTime,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.humidity,
      required this.dewPoint,
      required this.windSpeed,
      required this.windDegree,
      required this.visibility,
      required this.windGust,
      required this.weather});

  // Factory method to create HourlyWeatherModel from JSON data
  factory HourlyWeatherModel.fromJson(Map<String, dynamic> data) {
    final dateTime = data["dt"] as int;
    final temp = data["temp"] - 273.15 as double;
    final feelsLike = data["feels_like"] - 273.15 as double;
    final pressure = data["pressure"] as int;
    final humidity = data["humidity"] as int;
    final dewPoint = data["dew_point"] - 273.15 as double;
    final windGust = data["wind_gust"] as double;
    final visibility = data["visibility"] as int;
    final windSpeed = data["wind_speed"] as double;
    final windDegree = data["wind_deg"] as int;
    final weatherData = data["weather"][0] as Map<String, dynamic>;

    // Use the first element of the weatherData list to create SubWeather
    final weather = SubWeather.fromJson(weatherData);

    return HourlyWeatherModel(
        dateTime: dateTime,
        temp: temp,
        feelsLike: feelsLike,
        pressure: pressure,
        humidity: humidity,
        dewPoint: dewPoint,
        windSpeed: windSpeed,
        windDegree: windDegree,
        visibility: visibility,
        windGust: windGust,
        weather: weather);
  }
}
