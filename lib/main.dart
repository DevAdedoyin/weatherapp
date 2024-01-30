import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';
import 'package:weatherapp/src/themes/theme_constants.dart';
import 'package:weatherapp/src/themes/theme_manager.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: WeatherApp()));
}

class WeatherApp extends ConsumerStatefulWidget {
  const WeatherApp({super.key});

  @override
  ConsumerState<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends ConsumerState<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    ThemeManager themeManager = ThemeManager();
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      title: 'Weather Monitor',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
    );
  }
}
