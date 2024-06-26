import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/features/authentication/presentation/forgot_pasword.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/authentication/presentation/login.dart';
import 'package:weatherapp/src/features/authentication/presentation/register.dart';
import 'package:weatherapp/src/features/geo_location/presentation/user_location.dart';
import 'package:weatherapp/src/features/onboarding/onboarding/onboarding_screen.dart';
import 'package:weatherapp/src/features/onboarding/splash_screen.dart';
// import 'package:weatherapp/src/features/authentication/presentation/change_pasword_screen.dart';
import 'package:weatherapp/src/features/weather/presentation/change_pasword_screen.dart';
import 'package:weatherapp/src/features/weather/presentation/daily_weather_detail_screen.dart';
import 'package:weatherapp/src/features/weather/presentation/dashboard/dashboard.dart';
import 'package:weatherapp/src/features/weather/presentation/hourly_weather/hourly_weather_detail.dart';
import 'package:weatherapp/src/features/weather/presentation/search_detail_screen.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/route_error_screen.dart';

GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: AppRoutes.root,
        builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      path: AppRoutes.userLocatorPage,
      builder: (context, state) => const UserLocation(),
    ),
    GoRoute(
      path: AppRoutes.hourlyWeatherDetails,
      builder: (context, state) => const HourlyWeatherDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.searchCityWeatherDetails,
      builder: (context, state) => const SearchDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.dailyDetails,
      builder: (context, state) => const DailyWeatherDetail(),
    ),
    GoRoute(
      path: AppRoutes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
  errorBuilder: (context, state) => RouteErrorScreen(
    errorMsg: state.error.toString(),
  ),
);
