import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdNotifier extends StateNotifier<BannerAd?> {
  BannerAdNotifier() : super(null) {
    _loadAd();
  }

  // PRODUCTION
  final adUnitId = dotenv.env["BANNER_AD_UNIT_ANDROID"];
  final adUnitIdIOS = dotenv.env["BANNER_AD_UNIT_IOS"];

  // DEVELOPMENT
  final testAdUnitId = dotenv.env["SAMPLE_BANNER_ID_ANDROID"];

  void _loadAd() {
    final banner = BannerAd(
      adUnitId:
      testAdUnitId!,
      // Platform.isAndroid ? adUnitId! : adUnitIdIOS!,
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

// HOME PAGE BANNER
final bannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final banner2AdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final bannerHourlyAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

// SEARCH PAGE BANNER
final searchBannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final searchDetailBannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final searchDetail2BannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final forecastBannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final forecastDetailBannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final settingsBannerAdProvider =
    StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final tipsBannerAdProvider =
StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});

final weatherFactsBannerAdProvider =
StateNotifierProvider<BannerAdNotifier, BannerAd?>((ref) {
  return BannerAdNotifier();
});