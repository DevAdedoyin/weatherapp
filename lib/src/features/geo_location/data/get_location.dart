import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateWeatherLocation {
  static void getLocation() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey!);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lon', position.longitude);

    final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    await prefs.setString('address', address.first.addressLine!);
  }
}
