// Importing the necessary dependency for the WeatherModel class
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

// Model class representing daily weather information
class DailyWeatherModel {
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
  final SubCurrentWeather weather; // Detailed weather information

  // Constructor for the DailyWeatherModel class
  DailyWeatherModel({
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

  // Factory method to create a DailyWeatherModel instance from JSON data
  factory DailyWeatherModel.fromJson(Map<String, dynamic> data) {
    // Extracting individual properties from the JSON data
    final dateTime = data["dt"] as int;
    final sunrise = data["sunrise"] as int;
    final sunset = data["sunset"] as int;
    final moonrise = data["moonrise"] as int;
    final moonset = data["moonset"] as int;
    final pressure = data["pressure"] as int;
    final summary = data["summary"] as String;
    final humidity = data["humidity"] as int;
    final dewPoint = data["dew_point"] as double;
    final windSpeed = data["wind_speed"] as double;
    final windDegree = data["wind_deg"] as int;
    final weatherData = data["weather"] as List<Map<String, dynamic>>;

    // Creating Temp object from the "temp" property in the JSON data
    final temperature = data["temp"] as Map<String, dynamic>;
    final temp = Temp.fromJson(temperature);

    // Creating FeelsLike object from the "feels_like" property in the JSON data
    final feelsLike_ = data["feels_like"] as Map<String, dynamic>;
    final feelsLike = FeelsLike.fromJson(feelsLike_);

    // Use the first element of the weatherData list to create SubCurrentWeather
    final weather = SubCurrentWeather.fromJson(weatherData);

    // Returning a new instance of DailyWeatherModel with extracted data
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
      weather: weather,
    );
  }
}

// Feels Like Object
class FeelsLike {
  final double day; // "Feels like" temperature during the day
  final double night; // "Feels like" temperature during the night
  final double eve; // "Feels like" temperature during the evening
  final double morn; // "Feels like" temperature during the morning

  // Constructor for the FeelsLike class
  FeelsLike({
    required this.day,
    required this.eve,
    required this.morn,
    required this.night,
  });

  // Factory method to create a FeelsLike instance from JSON data
  factory FeelsLike.fromJson(Map<String, dynamic> data) {
    // Extracting individual properties from the JSON data
    final day = data["day"] as double;
    final night = data["night"] as double;
    final eve = data["eve"] as double;
    final morn = data["morn"] as double;
    // Returning a new instance of FeelsLike with extracted data
    return FeelsLike(day: day, eve: eve, morn: morn, night: night);
  }
}

// Temperature object
class Temp {
  final double day; // Temperature during the day
  final double min; // Minimum temperature
  final double max; // Maximum temperature
  final double night; // Temperature during the night
  final double eve; // Temperature during the evening
  final double morn; // Temperature during the morning

  // Constructor for the Temp class
  Temp({
    required this.day,
    required this.eve,
    required this.max,
    required this.min,
    required this.morn,
    required this.night,
  });

  // Factory method to create a Temp instance from JSON data
  factory Temp.fromJson(Map<String, dynamic> data) {
    // Extracting individual properties from the JSON data
    final day = data["day"] as double;
    final min = data["min"] as double;
    final max = data["max"] as double;
    final night = data["night"] as double;
    final eve = data["eve"] as double;
    final morn = data["morn"] as double;
    // Returning a new instance of Temp with extracted data
    return Temp(
        day: day, eve: eve, max: max, min: min, morn: morn, night: night);
  }
}
