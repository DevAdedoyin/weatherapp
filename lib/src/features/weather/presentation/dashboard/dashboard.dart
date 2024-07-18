import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/weather/data/repositories/bottom_nav_state.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/daily_forecast_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/home_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/search_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/settings_page.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final currentUser = FirebaseAuth.instance.currentUser;

  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    DailyForecastPage(),
    SettingsPage()
  ];

  static const List<Widget> _unAuthpUserPages = [
    HomePage(),
    SearchPage(),
    DailyForecastPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavState);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: currentUser == null
            ? _unAuthpUserPages.elementAt(currentIndex)
            : _pages.elementAt(currentIndex),
      ),
      bottomNavigationBar: currentUser == null
          ? BottomNavigationBar(
              backgroundColor:
                  isDarkMode ? AppColors.scaffoldBgColor : Colors.white,
              selectedLabelStyle:
                  const TextStyle(color: Colors.red, fontSize: 14),
              selectedItemColor: Colors.red,
              unselectedItemColor:
                  isDarkMode ? Colors.white : AppColors.scaffoldBgColor,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  // backgroundColor: AppColors.scaffoldBgColor,
                  icon: currentIndex == 0
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 7),
                          child: const Icon(
                            Icons.home_filled,
                            color: Colors.red,
                          ))
                      : Icon(
                          Icons.home_filled,
                          color: isDarkMode ? Colors.white60 : Colors.black87,
                          size: 30,
                        ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    // backgroundColor: AppColors.scaffoldBgColor,
                    icon: currentIndex == 1
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: const Icon(Icons.search))
                        : Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.white60 : Colors.black87,
                            size: 30,
                          ),
                    label: "Search"),
                BottomNavigationBarItem(
                    // backgroundColor: AppColors.scaffoldBgColor,
                    icon: currentIndex == 2
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: const Icon(Icons.wb_cloudy))
                        : Icon(
                            Icons.wb_cloudy,
                            color: isDarkMode ? Colors.white60 : Colors.black87,
                            size: 30,
                          ),
                    label: "Forecast"),
              ],
              currentIndex: currentIndex,
              onTap: (index) => ref.read(bottomNavState.notifier).state = index,
            )
          : BottomNavigationBar(
              backgroundColor:
                  isDarkMode ? AppColors.scaffoldBgColor : Colors.white,
              selectedLabelStyle:
                  const TextStyle(color: Colors.red, fontSize: 14),
              selectedItemColor: Colors.red,
              unselectedItemColor:
                  isDarkMode ? Colors.white : AppColors.scaffoldBgColor,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  // backgroundColor: AppColors.scaffoldBgColor,
                  icon: currentIndex == 0
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 7),
                          child: const Icon(Icons.home_filled))
                      : Icon(
                          Icons.home_filled,
                          color: isDarkMode ? Colors.white60 : Colors.black87,
                          size: 30,
                        ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    // backgroundColor: AppColors.scaffoldBgColor,
                    icon: currentIndex == 1
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: const Icon(Icons.search))
                        : Icon(
                            Icons.search,
                            color: isDarkMode ? Colors.white60 : Colors.black87,
                            size: 30,
                          ),
                    label: "Search"),
                BottomNavigationBarItem(
                    // backgroundColor: AppColors.scaffoldBgColor,
                    icon: currentIndex == 2
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: const Icon(Icons.wb_cloudy))
                        : Icon(
                            Icons.wb_cloudy,
                            color: isDarkMode ? Colors.white60 : Colors.black87,
                            size: 30,
                          ),
                    label: "Forecast"),
                BottomNavigationBarItem(
                    // backgroundColor: AppColors.scaffoldBgColor,
                    icon: currentIndex == 3
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: const Icon(Icons.settings))
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
    );
  }
}
