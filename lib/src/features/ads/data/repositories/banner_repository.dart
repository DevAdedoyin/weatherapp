import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdNotifier extends StateNotifier<BannerAd?> {
  BannerAdNotifier() : super(null) {
    _loadAd();
  }

  final adUnitId = dotenv.env["BANNER_AD_UNIT"];

  void _loadAd() {
    final banner = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          state = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          state = null;
        },
      ),
    );

    banner.load();
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}

final bannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});
