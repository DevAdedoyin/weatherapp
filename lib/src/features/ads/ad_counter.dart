import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdDisplayCounter {
  static void addDisplayCounter(showAd, {double adPoint = 0.5}) async {
    SharedPreferences counter = await SharedPreferences.getInstance();

    double? adNoDisplayCount = counter.getDouble("adNoDisplayCount") ?? adPoint;

    double? adNoDisplayCount_ = adNoDisplayCount + adPoint;
    print("AD COUNT $adNoDisplayCount");
    // print(FirebaseAuth.instance.currentUser?.email);

    if (FirebaseAuth.instance.currentUser?.email != null) {
      if (adNoDisplayCount_ < 12.0) {
        counter.setDouble("adNoDisplayCount", adNoDisplayCount_);
      } else {
        showAd.showAd();
        counter.setDouble("adNoDisplayCount", 0);
      }
    } else {
      if (adNoDisplayCount_ < 8.0) {
        counter.setDouble("adNoDisplayCount", adNoDisplayCount_);
      } else {
        showAd.showAd();
        counter.setDouble("adNoDisplayCount", 0);
      }
    }
  }
}
