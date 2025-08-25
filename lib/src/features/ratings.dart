import 'dart:io';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

final InAppReview _inAppReview = InAppReview.instance;

class AppRatings {
  static const String _launchCountKey = 'launch_count';
  static const String _reviewShownKey = 'review_shown';

  static Future<void> requestReview() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt(_launchCountKey) ?? 0;
    bool reviewShown = prefs.getBool(_reviewShownKey) ?? false;

    launchCount++;
    await prefs.setInt(_launchCountKey, launchCount);

    print(
        '[AppRatings] Launch count: $launchCount, Review shown: $reviewShown');

    // Condition to trigger review prompt
    if (launchCount >= 2 && !reviewShown) {
      bool isAvailable = await _inAppReview.isAvailable();
      print('[AppRatings] In-App Review Available: $isAvailable');

      try {
        if (isAvailable) {
          print('[AppRatings] Requesting in-app review...');
          await _inAppReview.requestReview();
          await prefs.setBool(_reviewShownKey, true);
        } else {
          print(
              '[AppRatings] In-app review not available, opening store listing...');
          await _openStoreListing();
        }
      } catch (e) {
        print('[AppRatings] Error showing review: $e');
        await _openStoreListing();
      }
    }
  }

  static Future<void> _openStoreListing() async {
    try {
      if (Platform.isAndroid) {
        await _inAppReview.openStoreListing();
      } else if (Platform.isIOS) {
        await _inAppReview.openStoreListing(appStoreId: '6751232705');
      }
    } catch (e) {
      print('[AppRatings] Error opening store listing: $e');
    }
  }


  static Future<void> forceReview() async {
    try {
      print('[AppRatings] Forcing in-app review (debug mode)...');
      await _inAppReview.requestReview();
    } catch (e) {
      print('[AppRatings] Error forcing review: $e');
    }
  }
}
