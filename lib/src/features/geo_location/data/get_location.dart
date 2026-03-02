import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/features/geo_location/repositories/address_repo.dart';
import 'package:weatherapp/src/features/weather/data/repositories/bottom_nav_state.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

class GenerateWeatherLocation {
  static void getLocation(WidgetRef ref) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final androidGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_ANDROID'];
    final iOSGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_IOS'];

    final apiKey =
        Platform.isAndroid ? androidGoogleMapsApiKey : iOSGoogleMapsApiKey;

    // final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey!);

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
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
        desiredAccuracy: LocationAccuracy.best);

    // print(position.latitude);
    // print(position.longitude);
    await prefs.setDouble('lat', position.latitude);
    await prefs.setDouble('lon', position.longitude);

    ref.read(latlngAQIState.notifier).state = {
      "lat": position.latitude,
      "lon": position.longitude
    };

    final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude));
    // print("${address.first.thoroughfare} ${address.first.subAdminArea!}");
    await prefs.setString('address',
        "${address.first.thoroughfare ?? ''}, ${address.first.subAdminArea ?? ''}");

    await prefs.setString("country_name", address.first.countryName!);

    // print("COUNTRY: ${address.first.countryName}");

    ref.read(bottomNavState.notifier).state = 0;
    goRouter.go(AppRoutes.dashboard);
  }

  static Future<Map<String, dynamic>> getLocationBySearch(
      {required String location}) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final androidGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_ANDROID'];
    final iOSGoogleMapsApiKey = dotenv.env['GOOGLE_CLOUD_KEY_IOS'];

    final apiKey =
        Platform.isAndroid ? androidGoogleMapsApiKey : iOSGoogleMapsApiKey;

    // final apiKey = dotenv.env['REACT_APP_GOOGLE_API_KEY'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey!);

    final storedAddress = await geocoder.findAddressesFromQuery(location);

    // print(storedAddress.first.coordinates);
    Coordinates coords = storedAddress.first.coordinates;

    final lat = coords.latitude;
    final lon = coords.longitude;

    // Create a ProviderContainer
    final latlngContainer = ProviderContainer();
    final addressContainer = ProviderContainer();

    // Read the state from the container
    latlngContainer.read(latlngState.notifier).state = {
      "lat": lat!,
      "lon": lon!
    };

    addressContainer.read(searchedALocation.notifier).state =
        "$location, ${storedAddress.first.countryName!}";

    String searchALocation = "$location, ${storedAddress.first.countryName!}";

    await prefs.setString(
        'searchedAddress', "$location, ${storedAddress.first.countryName!}");

    return {"lat": lat, "lon": lon, "address": searchALocation};
  }

  static Future<String?> address() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("address");
  }

  static Future<String?> searchedAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("searchedAddress");
  }
}
