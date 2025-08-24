import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

final InAppReview _inAppReview = InAppReview.instance;

class AppRatings {
  static Future<void> requestReview() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('launch_count') ?? 0;
    bool reviewShown = prefs.getBool('review_shown') ?? false;

    launchCount++;
    await prefs.setInt('launch_count', launchCount);
    if (launchCount >= 2 && !reviewShown) {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        await prefs.setBool('review_shown', true);
      } else {
        await _inAppReview.openStoreListing();
      }
    }
  }
}
