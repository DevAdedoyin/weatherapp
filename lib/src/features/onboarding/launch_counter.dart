import 'package:shared_preferences/shared_preferences.dart';

class LaunchCounter {
  static Future<int> launchCounter() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('launch_number') ?? 0;

    launchCount++;
    await prefs.setInt('launch_number', launchCount);
    return launchCount;
  }
}
