import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/exceptions/custom_exception.dart';
import 'package:weatherapp/src/features/geo_location/data/get_location.dart';
import 'package:weatherapp/src/features/geo_location/repositories/address_repo.dart';
import 'package:weatherapp/src/features/weather/domain/weather_model.dart';

class WeatherApiDataSource {
  // Asynchronous method to fetch weather data based on latitude and longitude
  static Future<WeatherModel> fetchWeather() async {
    // Retrieve the API key from the environment variables
    final apiKey = dotenv.env['REACT_APP_WEATHER_API_KEY'];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? lati = prefs.getDouble('lat');
    double? longi = prefs.getDouble('lon');

    String uri =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lati&lon=$longi&appid=$apiKey";
    final response = await http.get(Uri.parse(uri));

    final responseBody = jsonDecode(response.body);

    print(responseBody);

    if (response.statusCode == 200) {
      print("Hourly: ${responseBody["hourly"]}");
      return await WeatherModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw CustomException(
          message: "Error fetching data. Status code: ${response.statusCode}",
          statusCode: response.statusCode);
    }
  }

  static Future<WeatherModel> searchedWeather({required String city}) async {
    final apiKey = dotenv.env['REACT_APP_WEATHER_API_KEY'];

    final latlng =
        await GenerateWeatherLocation.getLocationBySearch(location: city);

    userSearchedAddress = latlng["address"] as String;

    // print("SEARCHER ${latlng["address"]}");
    final lat = latlng["lat"];
    final lon = latlng["lon"];

    // Construct the API endpoint URL with latitude, longitude, and API key
    String uri =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey";
    // Perform an HTTP GET request to the API endpoint
    final response = await http.get(Uri.parse(uri));

    // Decode the JSON response body
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {

      return WeatherModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw CustomException(
          message: "Error fetching data. Status code: ${response.statusCode}",
          statusCode: response.statusCode);
    }
  }
}

// Create a provider for the WeatherApiDataSource class
final weatherProvider =
    Provider<WeatherApiDataSource>((ref) => WeatherApiDataSource());
