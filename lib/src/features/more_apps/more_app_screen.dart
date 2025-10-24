import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ads/data/repositories/banner_repository.dart';

class MoreAppScreen extends ConsumerWidget {
  const MoreAppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    const String myRecipeDiaryIOS =
        'https://apps.apple.com/us/app/my-recipe-diary/id6753172362?platform=iphone';
    const String myRecipeDiaryAndroid =
        'https://play.google.com/store/apps/details?id=com.pauversildo.myrecipediary';
    const String rateMateAndroid =
        "https://play.google.com/store/apps/details?id=com.pauversil.ratemate";

    Future<void> launchWeatherMonitorIOS() async {
      final Uri url = Uri.parse(myRecipeDiaryIOS);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $myRecipeDiaryIOS');
      }
    }

    Future<void> launchWeatherMonitorAndroid() async {
      final Uri url = Uri.parse(myRecipeDiaryAndroid);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $myRecipeDiaryAndroid');
      }
    }

    Future<void> launchRateMateAndroid() async {
      final Uri url = Uri.parse(rateMateAndroid);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $rateMateAndroid');
      }
    }

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final bannerAd = ref.watch(exploreMoreAppBannerAdProvider);
    // final user = FirebaseAuth.instance.currentUser;
    Size size_ = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our App Collection',
          style: GoogleFonts.permanentMarker(color: Colors.white, fontSize: 20),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: isDarkMode ? Colors.red : Colors.blue,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              color: isDarkMode
                  ? AppColors.cardDarkModeColor
                  : AppColors.cardLightModeColor,
              child: ListTile(
                // isThreeLine: true,
                leading: SizedBox(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/mrd_logo.png")),
                )),
                title: Text(
                  'My Recipe Diary',
                  style: GoogleFonts.acme(fontSize: 18),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: launchWeatherMonitorIOS,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                      ),
                      label: const Text(
                        "iOS",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.apple,
                        color: Colors.white,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: launchWeatherMonitorAndroid,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      label: const Text(
                        "Android",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.android,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              color: isDarkMode
                  ? AppColors.cardDarkModeColor
                  : AppColors.cardLightModeColor,
              child: ListTile(
                // isThreeLine: true,
                leading: SizedBox(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        "assets/images/rm_logo2.PNG",
                        fit: BoxFit.cover,
                      )),
                )),
                title: Text(
                  'Rate Mate',
                  style: GoogleFonts.acme(fontSize: 18),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: launchRateMateAndroid,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      label: const Text(
                        "Android",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.android,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            if (bannerAd != null)
              SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.90,
                child: AdWidget(ad: bannerAd),
              ),
          ],
        ),
      ),
    );
  }
}
