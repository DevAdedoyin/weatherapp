import 'package:riverpod/riverpod.dart';

final searchCity =
    StateProvider<Map<String, String>>((ref) => {"city": "", "continent": ""});
