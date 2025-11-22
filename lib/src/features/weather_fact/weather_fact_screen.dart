import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/ads/data/repositories/banner_repository.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

import '../ads/ad_counter.dart';
import '../ads/data/repositories/interstital_repository.dart';

class WeatherFactScreen extends ConsumerStatefulWidget {
  const WeatherFactScreen({super.key});

  @override
  ConsumerState<WeatherFactScreen> createState() => _WeatherFactScreenState();
}

class _WeatherFactScreenState extends ConsumerState<WeatherFactScreen> {
  final Random _random = Random();
  List<dynamic>? _shuffledFacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdDisplayCounter.addDisplayCounter(
        ref.read(interstitialAdProvider.notifier));
    ref.read(weatherFactsBannerAdProvider.notifier).loadAd();
  }

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
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            verticalGap(size.height * 0.06),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    goRouter.pop();
                  },
                  icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
                ),
                Expanded(
                  child: Text(
                    "Weather Knowledge Hub",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aboreto(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              user == null
                  ? "Top 10 Daily Weather Facts You Should Know"
                  : "Top 30 Daily Weather Facts You Should Know",
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                fontWeight: FontWeight.normal,
                fontSize: 15.9,
              ),
            ),
            verticalGap(size.height * 0.015),
            if (bannerAd != null)
              SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: size.width * 0.9,
                child: AdWidget(ad: bannerAd),
              ),
            verticalGap(size.height * 0.013),
            FutureBuilder<DataSnapshot>(
              future: FirebaseDatabase.instance.ref("weatherFacts").get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          verticalGap(10),
                          Text("Loading Facts...")
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Expanded(
                    child: Center(child: Text("Error loading facts")),
                  );
                } else if (!snapshot.hasData || snapshot.data!.value == null) {
                  return Expanded(
                    child: Center(child: Text("No facts available")),
                  );
                } else {
                  final factsData =
                      Map<String, dynamic>.from(snapshot.data!.value as Map);

                  final factsList = (factsData["facts"] as List).cast<Map>();

                  final today = DateTime.now();
                  final seed =
                      today.year * 10000 + today.month * 100 + today.day;
                  final random = Random(seed);

                  print("Facts Data List $factsList");

                  factsList.shuffle(random);

                  final itemCount = user == null ? 10 : 30;

                  final randomFacts = factsList.take(itemCount).toList();

                  print("Shuffled Fact $_shuffledFacts");
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: itemCount,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: size.height * 0.005,
                              horizontal: size.height * 0.01),
                          child: Card(
                            elevation: 2,
                            color: isDarkMode
                                ? Colors.black45
                                : AppColors.cardLightModeColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                title: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        "(${index + 1}) ${randomFacts[index]["fact"].toString()}",
                                        style: TextStyle(fontSize: 15.5),
                                      ),
                                    ),
                                    Divider(
                                      color:
                                          isDarkMode ? Colors.red : Colors.blue,
                                    )
                                  ],
                                ),
                                subtitle: Text(
                                  randomFacts[index]["details"].toString(),
                                  style: TextStyle(
                                      fontSize: 14.2,
                                      fontWeight: FontWeight.w600),
                                ),
                                // leading: ClipOval(
                                //   child: Image.network(
                                //     randomFacts[0][index]["imageUrl"].toString(),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
