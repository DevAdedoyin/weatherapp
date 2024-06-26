import 'package:riverpod/riverpod.dart';

final openWeatherDetails = StateProvider<bool>((ref) => false);

final hourlyWeatherDetails = StateProvider<SelectedHourlyWeather>((ref) =>
    SelectedHourlyWeather(
        date: "dateTime",
        time: "time",
        desctiption: "desctiption",
        dewPoint: "dewPoint",
        feelsLike: "feelsLike",
        humidity: "humidity",
        image: "image",
        location: "location",
        pressure: "pressure",
        temp: "temp",
        position: 0,
        visibility: "visibility",
        windDegree: "windDegree",
        windGust: "windGust",
        windSpeed: "windSpeed",
        isFromSearch: false,
        address: ","));

class SelectedHourlyWeather {
  bool? isFromSearch;
  String address;
  String? image;
  String? location;
  String? date;
  String? time;
  String? temp;
  String? feelsLike;
  String? desctiption;
  String? pressure;
  String? humidity;
  String? dewPoint;
  String? visibility;
  String? windSpeed;
  String? windDegree;
  String? windGust;
  int? position;

  SelectedHourlyWeather(
      {required this.isFromSearch,
      required this.address,
      required this.date,
      required this.time,
      required this.desctiption,
      required this.dewPoint,
      required this.feelsLike,
      required this.humidity,
      required this.image,
      required this.location,
      required this.pressure,
      required this.position,
      required this.temp,
      required this.visibility,
      required this.windDegree,
      required this.windGust,
      required this.windSpeed});
}
