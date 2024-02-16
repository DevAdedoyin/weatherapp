import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:geolocator/geolocator.dart';

class GenerateWeatherLocation {
  static Future<Map<String, double>> getLocation() async {
    final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey!);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // final address = await geocoder.findAddressesFromCoordinates(
    //     Coordinates(position.latitude, position.longitude));

    return {"lat": position.latitude, "lon": position.longitude};
  }
}
