import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/features/ads/data/repositories/banner_repository.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

class WeatherFactScreen extends ConsumerStatefulWidget {
  const WeatherFactScreen({super.key});

  @override
  ConsumerState<WeatherFactScreen> createState() => _WeatherFactScreenState();
}

class _WeatherFactScreenState extends ConsumerState<WeatherFactScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;
    final bannerAd = ref.watch(weatherFactsBannerAdProvider);
    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: SizedBox(
          child: Column(
            children: [
              verticalGap(size.height * 0.06),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      goRouter.pop();
                    },
                    icon: Icon(Platform.isIOS
                        ? Icons.arrow_back_ios
                        : Icons.arrow_back),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        "Daily Weather Facts",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.aboreto(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  user == null
                      ? "Top 10 Daily Weather Facts You Should Know"
                      : "Top 30 Daily Weather Facts You Should Know",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.acme(
                      fontWeight: FontWeight.normal, fontSize: 15.9),
                ),
              ),
              verticalGap(10),
              if (bannerAd != null)
                SizedBox(
                  height: bannerAd.size.height.toDouble(),
                  width: size.width * 0.89,
                  child: AdWidget(ad: bannerAd),
                ),
              verticalGap(5),
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
