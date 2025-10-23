import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdDisplayCounter {
  static void addDisplayCounter(showAd) async {
    SharedPreferences counter = await SharedPreferences.getInstance();

    int? adNoDisplayCount = counter.getInt("adNoDisplayCount") ?? 0;

    int? adNoDisplayCount_ = adNoDisplayCount + 1;
    // print("AD COUNT $adNoDisplayCount");
    // print(FirebaseAuth.instance.currentUser?.email);

    if (FirebaseAuth.instance.currentUser?.email != null) {
      if (adNoDisplayCount_ <= 4) {
        counter.setInt("adNoDisplayCount", adNoDisplayCount_);
      } else {
        showAd.showAd();
        counter.setInt("adNoDisplayCount", 0);
      }
    } else {
      if (adNoDisplayCount_ <= 2) {
        counter.setInt("adNoDisplayCount", adNoDisplayCount_);
      } else {
        showAd.showAd();
        counter.setInt("adNoDisplayCount", 0);
      }
    }
  }
}
