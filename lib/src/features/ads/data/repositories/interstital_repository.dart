import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class InterstitialAdNotifier extends StateNotifier<InterstitialAd?> {
  InterstitialAdNotifier() : super(null) {
    _loadAd();
  }

  // PRODUCTION
  final adUnitId = dotenv.env["INTERSTITIAL_AD_UNIT_ANDROID"];
  final adUnitIdIOS = dotenv.env["INTERSTITIAL_AD_UNIT_IOS"];

  // DEVELOPMENT
  final testAdUnitId = dotenv.env["SAMPLE_INTERSTITIAL_ID_ANDROID"];

  void _loadAd() {
    InterstitialAd.load(
      adUnitId:
      // testAdUnitId!,
      Platform.isAndroid ? adUnitId! : adUnitIdIOS!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Interstitial loaded');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              state = null;
              _loadAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              state = null;
              _loadAd(); // Retry load
            },
          );
          state = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed to load: $error');
          state = null;
        },
      ),
    );
  }

  void showAd() {
    if (state != null) {
      state!.show();
    } else {
      debugPrint('Interstitial not ready yet');
    }
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}

final interstitialAdProvider =
    StateNotifierProvider<InterstitialAdNotifier, InterstitialAd?>(
        (ref) => InterstitialAdNotifier());
