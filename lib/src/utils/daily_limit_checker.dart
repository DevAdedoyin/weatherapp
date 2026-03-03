import 'package:shared_preferences/shared_preferences.dart';

class DailyLimitChecker {
  static Future<bool> checkDailyLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime now = DateTime.now();
    // Get only the date part to compare days
    DateTime today = DateTime(now.year, now.month, now.day);
    int lastResetTimestamp = prefs.getInt("lastResetTimestamp") ?? 0;
    DateTime lastResetDate =
        DateTime.fromMillisecondsSinceEpoch(lastResetTimestamp);

    if (today.isAfter(lastResetDate)) {
      // It's a new day, reset the counter
      await prefs.setInt("limitCount", 0);
      await prefs.setInt("lastResetTimestamp", today.millisecondsSinceEpoch);
    }

    int currentCount = prefs.getInt("limitCount") ?? 0;

    print("CURRENT COUNT $currentCount");

    if (currentCount >= 7) {
      return true;
    }

    currentCount++;
    await prefs.setInt("limitCount", currentCount);

    return currentCount >= 7;
  }
}
