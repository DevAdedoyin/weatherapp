import 'dart:io';

import 'package:check_app_version/components/dialogs/app_version_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/app_update_notification/check_updates.dart';
import 'package:weatherapp/src/features/ratings.dart';
import 'package:weatherapp/src/features/weather/data/repositories/bottom_nav_state.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/air_quality.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/daily_forecast_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/home_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/search_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/settings_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/tips_page.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

import '../../../ads/ad_counter.dart';
import '../../../ads/data/repositories/interstital_repository.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final currentUser = FirebaseAuth.instance.currentUser;

  static const List<Widget> _pages = [
    HomePage(),
    AirQuality(),
    DailyForecastPage(),
    SearchPage(),
    SettingsPage()
  ];

  static const List<Widget> _unAuthpUserPages = [
    HomePage(),
    SearchPage(),
    DailyForecastPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdates(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavState);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        onPressed: () {
          if (kDebugMode) {
            AppRatings.forceReview();
          } else {
            AppRatings.requestReview();
          }
          AdDisplayCounter.addDisplayCounter(
              ref.read(interstitialAdProvider.notifier));
          goRouter.push(AppRoutes.weatherFact);
        },
        child: Icon(
          FontAwesomeIcons.book,
          color: isDarkMode ? Colors.red : Colors.blue,
          size: 30,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? "assets/images/darkmode.jpg"
                  : "assets/images/sky.jpg"),
              fit: BoxFit.cover),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child:
              // currentUser == null
              // ? _unAuthpUserPages.elementAt(currentIndex)
              // :
              _pages.elementAt(currentIndex),
        ),
      ),
      bottomNavigationBar:
          // currentUser == null
          //     ? BottomNavigationBar(
          //         backgroundColor:
          //             isDarkMode ? AppColors.scaffoldBgColor : Colors.white,
          //         selectedLabelStyle:
          //             const TextStyle(color: Colors.red, fontSize: 14),
          //         selectedItemColor: Colors.red,
          //         unselectedItemColor:
          //             isDarkMode ? Colors.white : AppColors.scaffoldBgColor,
          //         showSelectedLabels: true,
          //         showUnselectedLabels: false,
          //         items: [
          //           BottomNavigationBarItem(
          //             // backgroundColor: AppColors.scaffoldBgColor,
          //             icon: currentIndex == 0
          //                 ? Container(
          //                     decoration: BoxDecoration(
          //                         color: Colors.white54.withOpacity(0.15),
          //                         borderRadius: BorderRadius.circular(20)),
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 7, vertical: 7),
          //                     child: const Icon(
          //                       Icons.home_filled,
          //                       color: Colors.red,
          //                     ))
          //                 : Icon(
          //                     Icons.home_filled,
          //                     color: isDarkMode ? Colors.white60 : Colors.black87,
          //                     size: 30,
          //                   ),
          //             label: "Home",
          //           ),
          //           BottomNavigationBarItem(
          //               // backgroundColor: AppColors.scaffoldBgColor,
          //               icon: currentIndex == 1
          //                   ? Container(
          //                       decoration: BoxDecoration(
          //                           color: Colors.white54.withOpacity(0.15),
          //                           borderRadius: BorderRadius.circular(20)),
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 7, vertical: 7),
          //                       child: const Icon(Icons.search))
          //                   : Icon(
          //                       Icons.search,
          //                       color: isDarkMode ? Colors.white60 : Colors.black87,
          //                       size: 30,
          //                     ),
          //               label: "Search"),
          //           BottomNavigationBarItem(
          //               // backgroundColor: AppColors.scaffoldBgColor,
          //               icon: currentIndex == 2
          //                   ? Container(
          //                       decoration: BoxDecoration(
          //                           color: Colors.white54.withOpacity(0.15),
          //                           borderRadius: BorderRadius.circular(20)),
          //                       padding: const EdgeInsets.symmetric(
          //                           horizontal: 7, vertical: 7),
          //                       child: const Icon(Icons.wb_cloudy))
          //                   : Icon(
          //                       Icons.wb_cloudy,
          //                       color: isDarkMode ? Colors.white60 : Colors.black87,
          //                       size: 30,
          //                     ),
          //               label: "Forecast"),
          //         ],
          //         currentIndex: currentIndex,
          //         onTap: (index) => ref.read(bottomNavState.notifier).state = index,
          //       )
          //     :

          BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: TextStyle(
            color: isDarkMode ? Colors.red : Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        selectedItemColor: isDarkMode ? Colors.red : Colors.blue,
        unselectedItemColor: isDarkMode ? Colors.white : Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? Colors.black87 : Colors.white70,
            // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
            icon: currentIndex == 0
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white54.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    child: const Icon(CupertinoIcons.cloud_moon_bolt_fill))
                : Icon(
                    Icons.cloud,
                    color: isDarkMode ? Colors.white60 : Colors.black87,
                    size: 30,
                  ),
            label: "Today",
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 1
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(CupertinoIcons.wind_snow))
                  : Icon(
                      Icons.air,
                      color: isDarkMode ? Colors.white60 : Colors.black87,
                      size: 30,
                    ),
              label: "Air Quality"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 2
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(CupertinoIcons.calendar))
                  : Icon(
                      Icons.calendar_month,
                      color: isDarkMode ? Colors.white60 : Colors.black87,
                      size: 30,
                    ),
              label: currentUser == null ? "5 Days" : "7 Days"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 3
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(CupertinoIcons.doc_text_search))
                  : Icon(
                      Icons.search,
                      color: isDarkMode ? Colors.white60 : Colors.black87,
                      size: 30,
                    ),
              label: "Search"),
          BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 4
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(CupertinoIcons.settings_solid))
                  : Icon(
                      Icons.settings,
                      color: isDarkMode ? Colors.white60 : Colors.black87,
                      size: 30,
                    ),
              label: "Settings"),
        ],
        currentIndex: currentIndex,
        onTap: (index) => ref.read(bottomNavState.notifier).state = index,
      ),
      // extendBody: true,
    );
  }
}
