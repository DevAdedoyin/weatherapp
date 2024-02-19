import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

class GenerateWeatherLocation {
  static void getLocation() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey!);

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    print(position.longitude);
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lon', position.longitude);

    final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    print(address.first.addressLine!);
    await prefs.setString('address', address.first.addressLine!);

    goRouter.go(AppRoutes.dashboard);
  }
}
