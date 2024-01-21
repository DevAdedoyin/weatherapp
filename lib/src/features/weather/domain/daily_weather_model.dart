import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

class DailyWeatherModel {
  final int dateTime;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final String summary;
  final Map<String, dynamic> temp;
  final Map<String, dynamic> feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDegree;
  final SubCurrentWeather weather;

  DailyWeatherModel(
      {required this.dateTime,
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
      required this.weather});

  factory DailyWeatherModel.fromJson(Map<String, dynamic> data) {
    final dateTime = data["dt"] as int;
    final sunrise = data["sunrise"] as int;
    final sunset = data["sunset"] as int;
    final moonrise = data["moonrise"] as int;
    final moonset = data["moonset"] as int;
    final temp = data["temp"] as Map<String, dynamic>;
    final feelsLike = data["feels_like"] as Map<String, dynamic>;
    final pressure = data["pressure"] as int;
    final summary = data["summary"] as String;
    final humidity = data["humidity"] as int;
    final dewPoint = data["dew_point"] as double;
    final windSpeed = data["wind_speed"] as double;
    final windDegree = data["wind_deg"] as int;
    final weatherData = data["weather"] as List<Map<String, dynamic>>;

    // Use the first element of the weatherData list to create SubCurrentWeather
    final weather = SubCurrentWeather.fromJson(weatherData);

    return DailyWeatherModel(
        dateTime: dateTime,
        temp: temp,
        feelsLike: feelsLike,
        pressure: pressure,
        moonrise: moonrise,
        moonset: moonset,
        summary: summary,
        sunrise: sunrise,
        sunset: sunset,
        humidity: humidity,
        dewPoint: dewPoint,
        windSpeed: windSpeed,
        windDegree: windDegree,
        weather: weather);
  }
}
