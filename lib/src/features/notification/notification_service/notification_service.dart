import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/src/features/notification/data/data_sources/notification_service.dart';
import 'package:weatherapp/src/features/notification/data/repositories/notification_provider.dart';
import 'package:weatherapp/src/features/notification/domain/notification_model.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

final notificationState = StateProvider<bool>((ref) => true);
bool _fcmInitialized = false;

// Background handler - must be top-level
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("═══════════════════════════════════════════════════════");
  // print("🔴 BACKGROUND HANDLER STARTED");
  // print("═══════════════════════════════════════════════════════");

  await Firebase.initializeApp();

  try {
    // print("📩 Message ID: ${message.messageId}");
    // print("📩 Data: ${message.data}");
    // print("📩 Notification: ${message.notification?.toMap()}");
    // print("📩 Title from notification: ${message.notification?.title}");
    // print("📩 Body from notification: ${message.notification?.body}");
    // print("📩 Title from data: ${message.data['title']}");
    // print("📩 Body from data: ${message.data['body']}");

    // Ensure Flutter is initialized
    // print("⚙️ Initializing Flutter bindings...");
    WidgetsFlutterBinding.ensureInitialized();

    // print("⚙️ Initializing Firebase...");
    await Firebase.initializeApp();
    // print("✅ Firebase initialized");

    // Create service
    // print("⚙️ Creating NotificationStorageService...");

    final data = message.data;

    if (data.isEmpty || data['id'] == null) return;

    final service = NotificationStorageService();
    // print("✅ Service created");

    // Build notification object
    final notification = AppNotification(
      id: data['id'] as String,
      title: data['title'] as String? ?? 'Notification',
      body: data['body'] as String? ?? '',
      timestamp: DateTime.now(),
      imageUrl: data['imageUrl'] as String?,
      data: data,
      isRead: false,
    );

    // print("📦 Notification object created:");
    // print("   - ID: ${notification.id}");
    // print("   - Title: ${notification.title}");
    // print("   - Body: ${notification.body}");
    // print("   - ImageURL: ${notification.imageUrl}");
    // print("   - Data: ${notification.data}");
    // print("   - IsRead: ${notification.isRead}");

    // print("💾 Attempting to save notification...");
    await service.saveNotification(notification);
    // print("✅✅✅ NOTIFICATION SAVED SUCCESSFULLY! ✅✅✅");

    // Verify it was saved
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('saved_notifications');
    // print("🔍 Verification - Raw saved data: $savedData");
  } catch (e, stackTrace) {
    // print("❌❌❌ CRITICAL ERROR IN BACKGROUND HANDLER ❌❌❌");
    // print("Error: $e");
    // print("Stack trace:");
    // print(stackTrace);
  }

  // print("═══════════════════════════════════════════════════════");
  // print("🔴 BACKGROUND HANDLER ENDED");
  // print("═══════════════════════════════════════════════════════");
}

// Setup FCM
Future<void> setupFCM(WidgetRef ref) async {
  final messaging = FirebaseMessaging.instance;
  final notificationService = ref.read(notificationStorageServiceProvider);

  // Request permissions
  final settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  // print('🔔 Notification permissions: ${settings.authorizationStatus}');

  // Get token
  final token = await messaging.getToken();
  // print('📱 FCM token: $token');

  // Subscribe to topic
  await messaging.subscribeToTopic('weather');

  // Foreground messages
  FirebaseMessaging.onMessage.listen((message) async {
    // print('🟡 Foreground message received: ${message.data}');

    final data = message.data;
    if (data.isEmpty || data['id'] == null) return;

    final notification = AppNotification(
      id: data['id'] as String,
      title: data['title'] as String? ?? 'Notification',
      body: data['body'] as String? ?? '',
      timestamp: DateTime.now(),
      imageUrl: data['imageUrl'] as String?,
      data: data,
      isRead: false,
    );

    await notificationService.saveNotification(notification);

    // Update UI
    ref.invalidate(notificationsProvider);
    ref.invalidate(unreadCountProvider);
  });

  // Background tap listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    // print('🟠 Notification tapped (background): ${message.data}');

    // Get your service
    final notificationService = ref.read(notificationStorageServiceProvider);

    // Save the notification (if needed)
    final data = message.data;
    if (data.isNotEmpty && data['id'] != null) {
      final notification = AppNotification(
        id: data['id']?.toString() ?? '',
        title: data['title']?.toString() ?? 'Notification',
        body: data['body']?.toString() ?? '',
        timestamp: DateTime.now(),
        imageUrl: data['imageUrl']?.toString(),
        data: data,
        isRead: false,
      );

      await notificationService.saveNotification(notification);

      // Invalidate providers so UI updates
      ref.invalidate(notificationsProvider);
      ref.invalidate(unreadCountProvider);
    }

    // Handle navigation
    _handleNotificationNavigation(message.data);
  });

  // Handle app opened from terminated state
  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    // print('🔵 App opened from terminated state: ${initialMessage.data}');
    _handleNotificationNavigation(initialMessage.data);
  }
}

Future<void> disableFCM() async {
  try {
    // print("🔇 Disabling FCM...");
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.unsubscribeFromTopic("weather");
    // print("✅ Unsubscribed from topic");

    await messaging.deleteToken();
    // print("✅ Token deleted");

    // print("✅ FCM disabled successfully");
  } catch (e, stackTrace) {
    // print("❌ Failed to disable notifications: $e");
    // print("Stack trace: $stackTrace");
  }
}

void _handleNotificationNavigation(Map<String, dynamic> data) {
  // print('🧭 Navigation handler called');
  // print('🧭 Data: $data');

  if (data.containsKey("screen")) {
    final screen = data["screen"] as String;
    // print('🧭 Screen parameter: $screen');

    switch (screen) {
      case "notifications":
        // print('🧭 Navigating to: notifications');
        Platform.isAndroid
            ? goRouter.go(AppRoutes.notification)
            : goRouter.go(AppRoutes.dashboard);
        break;
      case "weather":
        final location = data["location"] as String?;
        // print('🧭 Navigating to: weather (location: $location)');
        Platform.isAndroid
            ? goRouter.go(AppRoutes.notification)
            : goRouter.go(AppRoutes.dashboard);
        break;
      // case "settings":
      //   print('🧭 Navigating to: settings');
      //   goRouter.go(AppRoutes.settings);
      //   break;
      // case "home":
      //   print('🧭 Navigating to: home');
      //   goRouter.go(AppRoutes.home);
      //   break;
      default:
        // print('⚠️ Unknown screen: $screen');
        goRouter.go(AppRoutes.dashboard);
    }
  } else {
    // print('ℹ️ No screen parameter, going to notifications');
    goRouter.go(AppRoutes.dashboard);
  }
}
