import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/src/features/share_app/share_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ads/ad_counter.dart';
import '../ads/data/repositories/banner_repository.dart';
import '../ads/data/repositories/interstital_repository.dart';

class ShareAppScreen extends ConsumerWidget {
  final String phoneNumber = '+447300850614';
  final String googleFormUrl = 'https://forms.gle/HiQEtA4QKxJGkD6H8';
  final String contactWebUrl =
      'https://devadedoyin.github.io/weather-monitor-support/';

  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ref.read(shareAppBannerAdProvider.notifier).loadAd();
    final bannerAd = ref.watch(shareAppBannerAdProvider);
    // final user = FirebaseAuth.instance.currentUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Share App',
          style: GoogleFonts.aBeeZee(color: Colors.white, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: isDarkMode ? Colors.red : Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Choose the OS version you want share',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.phone_iphone, color: Colors.green),
                  title: Text('Share for Iphone'),
                  trailing: Icon(Icons.share),
                  subtitle: Text("Tap to share to Iphone users."),
                  onTap: () {
                    AdDisplayCounter.addDisplayCounter(
                        ref.read(interstitialAdProvider.notifier));
                    ShareApp.shareApp(context, os: "iOS");
                  },
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.phone_android, color: Colors.blue),
                  title: Text('Share for Android'),
                  trailing: Icon(Icons.share),
                  subtitle: Text('Tap to share to Android users.'),
                  onTap: () {
                    AdDisplayCounter.addDisplayCounter(
                        ref.read(interstitialAdProvider.notifier));
                    ShareApp.shareApp(context, os: "Android");
                  },
                ),
              ),
              SizedBox(height: 16),
              if (bannerAd != null)
                SizedBox(
                  height: size.height * 0.25,
                  width: size.width * 0.90,
                  child: AdWidget(ad: bannerAd),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
