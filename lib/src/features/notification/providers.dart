import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

final notificationState = StateProvider<bool>((ref) => true);

void setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request iOS permissions (Android is automatic)
  await messaging.requestPermission();

  // Subscribe every user to weather
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

Future<void> disableFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  try {
    // Unsubscribe user from "weather" topic
    await messaging.unsubscribeFromTopic("weather");

    // Delete FCM token to fully stop all notifications for this device
    await messaging.deleteToken();
  } catch (e) {
    print("❌ Failed to disable notifications: $e");
  }
}
