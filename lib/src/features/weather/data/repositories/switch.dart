import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final switchModes = StateProvider<bool>((ref) {

  return false;
});

void switchModeFunction (bool mode) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("mode", mode);
}