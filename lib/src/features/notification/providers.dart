import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

void setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request iOS permissions (Android is automatic)
  await messaging.requestPermission();

  // Subscribe every user to "all"
  await messaging.subscribeToTopic("weather");

  // Handle notification tap when app is in foreground/background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.data["screen"] == "notifications") {
      goRouter.go(AppRoutes.userLocatorPage);
    }
  });

  // Handle tap if app was terminated
  RemoteMessage? initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null &&
      initialMessage.data["screen"] == "notifications") {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goRouter.go(AppRoutes.userLocatorPage);
    });
  }
}
