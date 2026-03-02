import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/air_quality_model/air_quality_model.dart';

Future<AirQualityResponse?> fetchAirQuality() async {
  final androidGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_ANDROID'];
  final iOSGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_IOS'];

  final apiKey =
      Platform.isAndroid ? androidGoogleMapsApiKey : iOSGoogleMapsApiKey;

  final url = Uri.parse(
    'https://airquality.googleapis.com/v1/currentConditions:lookup?key=$apiKey',
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final latitude = prefs.getDouble('lat');
  final longitude = prefs.getDouble('lon');

  GLOBAL_CURRENT_LATITUDE = latitude!;
  GLOBAL_CURRENT_LONGITUDE = longitude!;

  final body = jsonEncode({
    "location": {
      "latitude": latitude,
      "longitude": longitude,
    },
    "extraComputations": [
      "HEALTH_RECOMMENDATIONS",
      "DOMINANT_POLLUTANT_CONCENTRATION",
      "POLLUTANT_CONCENTRATION",
      "LOCAL_AQI",
      "POLLUTANT_ADDITIONAL_INFO"
    ],
    "uaqiColorPalette": "INDIGO_PERSIAN_DARK",
    "customLocalAqis": [],
    "universalAqi": false,
    "languageCode": "en"
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return AirQualityResponse.fromJson(jsonData);
    } else {
      print('Server error: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Failed to fetch air quality data: $e');
    return null;
  }
}

double GLOBAL_CURRENT_LATITUDE = 0.0;
double GLOBAL_CURRENT_LONGITUDE = 0.0;
