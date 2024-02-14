import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/weather/data/repositories/bottom_nav_state.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/forecast_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/home_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/search_page.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard_pages/settings_page.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ForecastPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavState);
    return Scaffold(
      body: _pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: currentIndex == 0
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white54.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    child: const Icon(Icons.home_filled))
                : const Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(Icons.search))
                  : const Icon(Icons.search),
              label: "Search"),
          BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(Icons.wb_cloudy))
                  : const Icon(Icons.wb_cloudy),
              label: "Forecast"),
          BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white54.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 7),
                      child: const Icon(Icons.settings))
                  : const Icon(Icons.settings),
              label: "Settings"),
        ],
        currentIndex: currentIndex,
        onTap: (index) => ref.read(bottomNavState.notifier).state = index,
      ),
    );
  }
}
