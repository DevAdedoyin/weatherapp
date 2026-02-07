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
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/daily_forecast_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/home_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/search_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/settings_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/tips_page.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import '../../../../constants/temp_airquality_countries.dart';
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
    // AirQuality(),
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
      floatingActionButtonLocation:
          Platform.isAndroid ? ExpandableFab.location : null,
      floatingActionButton: Platform.isIOS
          ? FloatingActionButton(
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
            )
          : ExpandableFab(
              overlayStyle: ExpandableFabOverlayStyle(
                color: Colors.black.withValues(alpha: 0.5),
                blur: 5,
              ),
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: Icon(
                  FontAwesomeIcons.bookOpenReader,
                  color: Colors.white,
                  size: 30,
                ),
                fabSize: ExpandableFabSize.regular,
                foregroundColor: Colors.white,
                backgroundColor: isDarkMode ? Colors.red : Colors.blue,
                shape: const CircleBorder(),
              ),
              closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                child: const Icon(FontAwesomeIcons.close),
                fabSize: ExpandableFabSize.small,
                foregroundColor: Colors.white,
                backgroundColor: isDarkMode ? Colors.red : Colors.blue,
                shape: const CircleBorder(),
              ),
              children: [
                FloatingActionButton.small(
                  // shape: const CircleBorder(),
                  heroTag: null,
                  backgroundColor: isDarkMode ? Colors.red : Colors.blue,
                  foregroundColor: Colors.white,
                  child: const Icon(
                    FontAwesomeIcons.book,
                  ),
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
                ),
                FloatingActionButton.small(
                  // shape: const CircleBorder(),
                  heroTag: null,
                  backgroundColor: isDarkMode ? Colors.red : Colors.blue,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.notifications),
                  onPressed: () {
                    AdDisplayCounter.addDisplayCounter(
                        ref.read(interstitialAdProvider.notifier));
                    goRouter.push(AppRoutes.notification);
                  },
                ),
              ],
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
        backgroundColor: Colors.blue,
        elevation: 0,
        selectedLabelStyle: TextStyle(
            color: isDarkMode ? Colors.red : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold),
        selectedItemColor: isDarkMode ? Colors.red : Colors.white,
        unselectedItemColor: isDarkMode ? Colors.white : Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            backgroundColor: isDarkMode ? Colors.black87 : Colors.blue.shade800,
            // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
            icon: currentIndex == 0
                ? Container(
                    decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade300 : Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    child: Icon(
                      CupertinoIcons.cloud_moon_bolt_fill,
                      color: isDarkMode ? Colors.red : Colors.blue,
                    ))
                : Icon(
                    CupertinoIcons.cloud_moon_bolt_fill,
                    color: isDarkMode ? Colors.white60 : Colors.white54,
                    size: 30,
                  ),

            label: "Today",
          ),
          // TODO: RETURN BACK AFTER DEPLOYING 4.0.0
          // BottomNavigationBarItem(
          //     backgroundColor:
          //         isDarkMode ? Colors.black87 : Colors.blue.shade800,
          //     // backgroundColor: Colors.transparent,
          //     // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
          //     icon: currentIndex == 1
          //         ? Container(
          //             decoration: BoxDecoration(
          //                 color:
          //                     isDarkMode ? Colors.grey.shade300 : Colors.white,
          //                 borderRadius: BorderRadius.circular(20)),
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 7, vertical: 7),
          //             child: Icon(
          //               CupertinoIcons.wind_snow,
          //               color: isDarkMode ? Colors.red : Colors.blue,
          //             ))
          //         : Icon(
          //             Icons.air,
          //             color: isDarkMode ? Colors.white60 : Colors.white54,
          //             size: 30,
          //           ),
          //     label: "Air Quality"),
          BottomNavigationBarItem(
              backgroundColor:
                  isDarkMode ? Colors.black87 : Colors.blue.shade800,

              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 1
                  ? Container(
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey.shade300 : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: Icon(
                        CupertinoIcons.calendar,
                        color: isDarkMode ? Colors.red : Colors.blue,
                      ))
                  : Icon(
                      CupertinoIcons.calendar,
                      color: isDarkMode ? Colors.white60 : Colors.white54,
                      size: 30,
                    ),
              label: currentUser == null ? "5 Days" : "7 Days"),
          BottomNavigationBarItem(
              backgroundColor:
                  isDarkMode ? Colors.black87 : Colors.blue.shade800,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 2
                  ? Container(
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey.shade300 : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: Icon(
                        CupertinoIcons.doc_text_search,
                        color: isDarkMode ? Colors.red : Colors.blue,
                      ))
                  : Icon(
                      CupertinoIcons.doc_text_search,
                      color: isDarkMode ? Colors.white60 : Colors.white54,
                      size: 30,
                    ),
              label: "Search"),
          BottomNavigationBarItem(
              backgroundColor:
                  isDarkMode ? Colors.black87 : Colors.blue.shade800,
              // isDarkMode ? AppColors.scaffoldBgColor : Colors.white54,
              icon: currentIndex == 3
                  ? Container(
                      decoration: BoxDecoration(
                          color:
                              isDarkMode ? Colors.grey.shade300 : Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: Icon(
                        CupertinoIcons.settings_solid,
                        color: isDarkMode ? Colors.red : Colors.blue,
                      ))
                  : Icon(
                      CupertinoIcons.settings_solid,
                      color: isDarkMode ? Colors.white60 : Colors.white54,
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
