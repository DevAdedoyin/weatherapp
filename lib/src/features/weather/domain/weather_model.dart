import 'package:weatherapp/src/features/weather/domain/daily_weather_model.dart';
import 'package:weatherapp/src/features/weather/domain/hourly_weather_model.dart';

class WeatherModel {
  final double lat;
  final double lon;
  final List<DailyWeatherModel> dailyWeather;
  final List<HourlyWeatherModel> hourlyWeather;
  final CurrentWeatherModel currentWeatherModel;
  final int timezoneOffset;

  // Constructor for WeatherModel
  WeatherModel({
    required this.lat,
    required this.lon,
    required this.dailyWeather,
    required this.hourlyWeather,
    required this.currentWeatherModel,
    required this.timezoneOffset,
  });

  // Factory method to create WeatherModel from JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    final lat = data['lat'] as double;
    final lon = data['lon'] as double;
    final timezone = data['timezone_offset'] as int;
    final currentWeatherModel = data['current'] as Map<String, dynamic>;
    final currentWeather = CurrentWeatherModel.fromJson(currentWeatherModel);

    // DAILY WEATHER DATA
    print("Daily KORENT: ${data['daily']}");
    List<Map<String, dynamic>> dailyWeatherList = [];
    int currPos = 0;
    final dailyWeather = data['daily'] as List;
    for (var item in dailyWeather) {
      if (item is Map<String, dynamic> && currPos <= 7) {
        print("Dailysssss: $currPos");
        if (currPos != 0) dailyWeatherList.add(item);
        currPos++;
      } else {
        break;
      }
    }
    final daily = dailyWeatherList.map((e) {
      print("dddooo: $e");
      return DailyWeatherModel.fromJson(e);
    }).toList();

    print("DAILYWEATHER $daily");

    // HOURLY WEATHER DATA
    print("KORENT: ${data['hourly']}");
    final hourlyWeather = data['hourly'] as List;

    List<Map<String, dynamic>> hourlyWeatherList = [];
    int pos = 0;
    for (var item in hourlyWeather) {
      if (item is Map<String, dynamic> && pos < 11) {
        print("Hourlyyysss: $pos");
        if (pos != 0) hourlyWeatherList.add(item);
        pos++;
      } else {
        break;
      }
    }

    // print("TESTING $hourlyWeatherList");
    final hourly = hourlyWeatherList.map((e) {
      print("eeeooo: $e");
      return HourlyWeatherModel.fromJson(e);
    }).toList();

    return WeatherModel(
        lat: lat,
        lon: lon,
        timezoneOffset: timezone,
        currentWeatherModel: currentWeather,
        dailyWeather: daily,
        hourlyWeather: hourly);
  }
}

// Model for current weather using type checks and none pattern matching to get
// current weather.
class CurrentWeatherModel {
  final int dateTime;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDegree;
  final SubWeather weather;

  // Constructor for CurrentWeatherModel
  CurrentWeatherModel(
      {required this.dateTime,
      required this.sunrise,
      required this.sunset,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.humidity,
      required this.dewPoint,
      required this.windSpeed,
      required this.windDegree,
      required this.weather});

  // Factory method to create CurrentWeatherModel from JSON data
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> data) {
    final dateTime = data["dt"] as int;
    final sunrise = data["sunrise"] as int;
    final sunset = data["sunset"] as int;
    final temp = data["temp"] - 273.15 as double;
    final feelsLike = data["feels_like"] - 273.15 as double;
    final pressure = data["pressure"] as int;
    final humidity = data["humidity"] as int;
    final dewPoint = data["dew_point"] - 273.15 as double;
    final windSpeed = data["wind_speed"] as double;
    final windDegree = data["wind_deg"] as int;
    final weatherData = data["weather"][0] as Map<String, dynamic>;

    // Use the first element of the weatherData list to create SubWeather
    final weather = SubWeather.fromJson(weatherData);

    return CurrentWeatherModel(
        dateTime: dateTime,
        sunrise: sunrise,
        sunset: sunset,
        temp: temp,
        feelsLike: feelsLike,
        pressure: pressure,
        humidity: humidity,
        dewPoint: dewPoint,
        windSpeed: windSpeed,
        windDegree: windDegree,
        weather: weather);
  }
}

// Sub-Model for current weather using type checks and none pattern matching
class SubWeather {
  final String main;
  final String description;
  final String icon;

  // Constructor for SubWeather
  SubWeather(
      {required this.main, required this.description, required this.icon});

  // Factory method to create SubWeather from JSON data
  factory SubWeather.fromJson(Map<String, dynamic> data) {
    final main = data['main'] as String;
    final description = data['description'] as String;
    final icon = data['icon'] as String;

    return SubWeather(main: main, description: description, icon: icon);
  }
}
