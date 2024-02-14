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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.wb_cloudy), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
        ],
        currentIndex: currentIndex,
        onTap: (index) => ref.read(bottomNavState.notifier).state = index,
      ),
    );
  }
}
