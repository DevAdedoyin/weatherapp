import 'package:riverpod/riverpod.dart';

final searchCity =
    StateProvider<Map<String, String>>((ref) => {"city": "", "continent": ""});

final fromSearchScreen = StateProvider<String>((ref) => "city");

final isFromSearchScreen = StateProvider<bool>((ref) => false);
