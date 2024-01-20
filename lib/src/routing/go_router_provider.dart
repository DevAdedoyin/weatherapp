import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/onboarding/splash_screen.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/route_error_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
            path: '/',
            name: AppRoutes.root,
            builder: (context, state) => const SplashScreen())
      ],
      errorBuilder: (context, state) =>
          RouteErrorScreen(errorMsg: state.error.toString()));
});
