import 'package:riverpod/riverpod.dart';

final currentAddress = StateProvider<String>((ref) => "");

final searchedALocation = StateProvider<String>((ref) => "");

final latlngState =
    StateProvider<Map<String, double>>((ref) => {"lat": 0.345, "lng": 60.878});

String userSearchedAddress = "";
