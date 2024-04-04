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

// Define a class for making API calls to retrieve weather data
class WeatherApiDataSource {
  // Asynchronous method to fetch weather data based on latitude and longitude
  static Future<WeatherModel> fetchWeather() async {
    // Retrieve the API key from the environment variables
    final apiKey = dotenv.env['REACT_APP_WEATHER_API_KEY'];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // final coord = await GenerateWeatherLocation.getLocation();
    // // final lat = coord["lat"];
    // // final lon = coord["lon"];
    double? lati = prefs.getDouble('lat');
    double? longi = prefs.getDouble('lon');

    // Construct the API endpoint URL with latitude, longitude, and API key
    String uri =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lati&lon=$longi&appid=$apiKey";
    // Perform an HTTP GET request to the API endpoint
    final response = await http.get(Uri.parse(uri));

    // Decode the JSON response body
    final responseBody = jsonDecode(response.body);

    // print(responseBody);
    // print(response.statusCode);
    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      print("Hourly: ${responseBody["hourly"]}");
      return await WeatherModel.fromJson(responseBody as Map<String, dynamic>);
    } else {
      throw CustomException(  
          message: "Error fetching data. Status code: ${response.statusCode}",
          statusCode: response.statusCode);
    }
  }

  // Asynchronous method to fetch weather data based on latitude and longitude
  static Future<WeatherModel> searchedWeather({required String city}) async {
    // Retrieve the API key from the environment variables
    final apiKey = dotenv.env['REACT_APP_WEATHER_API_KEY'];

    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    final latlng =
        await GenerateWeatherLocation.getLocationBySearch(location: city);

    print("CHECKING CITY: $city");

    // final addressContainer = ProviderContainer();

    // addressContainer.read(searchedALocation.notifier).state =
    //     latlng["address"] as String;

    userSearchedAddress = latlng["address"] as String;

    print("SEARCHER ${latlng["address"]}");
    final lat = latlng["lat"];
    final lon = latlng["lon"];
    // double? lati = prefs.getDouble('searchedLat');
    // double? longi = prefs.getDouble('searchedLon');

    // Construct the API endpoint URL with latitude, longitude, and API key
    String uri =
        "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey";
    // Perform an HTTP GET request to the API endpoint
    final response = await http.get(Uri.parse(uri));

    // Decode the JSON response body
    final responseBody = jsonDecode(response.body);

    // print(responseBody);
    // print(response.statusCode);
    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // print("Hourly: ${responseBody["hourly"]}");
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
