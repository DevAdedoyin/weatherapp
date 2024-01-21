class WeatherModel {
  final double lat;
  final double lon;
  final String? timezone;

  // Constructor for WeatherModel
  WeatherModel({required this.lat, required this.lon, this.timezone});

  // Factory method to create WeatherModel from JSON data
  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    final lat = data['lat'] as double;
    final lon = data['lon'] as double;
    return WeatherModel(lat: lat, lon: lon);
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
  final SubCurrentWeather weather;

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
    final temp = data["temp"] as double;
    final feelsLike = data["feels_like"] as double;
    final pressure = data["pressure"] as int;
    final humidity = data["humidity"] as int;
    final dewPoint = data["dew_point"] as double;
    final windSpeed = data["wind_speed"] as double;
    final windDegree = data["wind_deg"] as int;
    final weatherData = data["weather"] as List<Map<String, dynamic>>;

    // Use the first element of the weatherData list to create SubCurrentWeather
    final weather = SubCurrentWeather.fromJson(weatherData);

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
class SubCurrentWeather {
  final String main;
  final String description;
  final String icon;

  // Constructor for SubCurrentWeather
  SubCurrentWeather(
      {required this.main, required this.description, required this.icon});

  // Factory method to create SubCurrentWeather from JSON data
  factory SubCurrentWeather.fromJson(List<Map<String, dynamic>> data) {
    final main = data[0]['main'] as String;
    final description = data[0]['description'] as String;
    final icon = data[0]['icon'] as String;

    return SubCurrentWeather(main: main, description: description, icon: icon);
  }
}
