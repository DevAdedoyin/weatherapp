import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weatherapp/src/features/notification/domain/notification_model.dart';

class NotificationStorageService {
  static const String _notificationsKey = 'saved_notifications';

  Future<void> saveNotification(AppNotification notification) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await getNotifications();

    // Add new notification at the beginning
    notifications.insert(0, notification);

    final jsonList = notifications.map((n) => n.toJson()).toList();
    await prefs.setString(_notificationsKey, jsonEncode(jsonList));
  }

  Future<List<AppNotification>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_notificationsKey);

    if (jsonString == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;

      return decoded
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('❌ Error decoding notifications: $e');
      return [];
    }
  }

  Future<void> deleteNotification(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await getNotifications();
    notifications.removeWhere((n) => n.id == id);

    final jsonList = notifications.map((n) => n.toJson()).toList();
    await prefs.setString(_notificationsKey, jsonEncode(jsonList));
  }

  Future<void> markAsRead(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await getNotifications();

    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
      final jsonList = notifications.map((n) => n.toJson()).toList();
      await prefs.setString(_notificationsKey, jsonEncode(jsonList));
    }
  }

  Future<void> markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();
    final notifications = await getNotifications();

    final updatedNotifications =
        notifications.map((n) => n.copyWith(isRead: true)).toList();

    final jsonList = updatedNotifications.map((n) => n.toJson()).toList();
    await prefs.setString(_notificationsKey, jsonEncode(jsonList));
  }

  Future<int> getUnreadCount() async {
    final notifications = await getNotifications();
    return notifications.where((n) => !n.isRead).length;
  }

  Future<void> clearAllNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notificationsKey);
  }
}
