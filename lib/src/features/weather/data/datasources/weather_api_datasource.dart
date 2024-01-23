import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/src/exceptions/custom_exception.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

// class WeatherApiDataSource {}

Future<WeatherModel> fetchWeather({
  double? lat,
  double? lon,
}) async {
  try {
    final apiKey = dotenv.env['REACT_APP_WEATHER_API_KEY'];
    String uri =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey";
    final response = await http.get(Uri.parse(uri));

    final responseBody = jsonDecode(response.body);

    print(responseBody);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw CustomException(
          message: "Error fetching data. Status code: ${response.statusCode}",
          statusCode: response.statusCode);
    }
  } catch (e) {
    // Handle the custom exception
    if (e is CustomException) {
      print('Caught custom exception: ${e.message}');
    } else {
      // Handle other exceptions
      print('Caught an exception: $e');
    }
    return WeatherModel(
        lat: 0.00, lon: 0.00, dailyWeather: [], hourlyWeather: []);
  }
}
