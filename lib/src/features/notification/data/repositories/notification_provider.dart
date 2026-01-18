import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/notification/data/data_sources/notification_service.dart';
import 'package:weatherapp/src/features/notification/domain/notification_model.dart';

// Service provider
final notificationStorageServiceProvider =
    Provider<NotificationStorageService>((ref) {
  return NotificationStorageService();
});

// Notifications list provider
final notificationsProvider =
    FutureProvider<List<AppNotification>>((ref) async {
  final service = ref.watch(notificationStorageServiceProvider);
  return service.getNotifications();
});

// Unread count provider
final unreadCountProvider = FutureProvider<int>((ref) async {
  final service = ref.watch(notificationStorageServiceProvider);
  return service.getUnreadCount();
});
