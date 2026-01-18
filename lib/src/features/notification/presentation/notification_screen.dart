import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/src/features/notification/data/repositories/notification_provider.dart';
import 'package:weatherapp/src/features/notification/domain/notification_model.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';

import '../../../common/gaps/sized_box.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    return PopScope(
      canPop: false, // ⛔ block default pop
      onPopInvokedWithResult: (bool didPop, Object? result) {
        // didPop == true  → default pop happened
        // didPop == false → pop was blocked, so perform custom navigation

        if (!didPop) {
          goRouter.go(AppRoutes.userLocatorPage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: isDarkMode ? Colors.red : Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => goRouter.go(AppRoutes.userLocatorPage),
          ),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  tooltipkey.currentState?.ensureTooltipVisible();
                },
                child: Tooltip(
                  message: "Swipe right to delete a notification.",
                  key: tooltipkey,
                  showDuration: Duration(seconds: 1),
                  triggerMode: TooltipTriggerMode.manual,
                  child: Icon(
                    CupertinoIcons.info_circle_fill,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        body: notificationsAsync.when(
          data: (notifications) => notifications.isEmpty
              ? _buildEmptyState(context)
              : _buildNotificationsList(context, ref, notifications),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error: $error'),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(isDarkMode
                ? "assets/images/darkmode.jpg"
                : "assets/images/sky.jpg"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade700,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 60,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Your notification will appear here once you\'ve received them.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    BuildContext context,
    WidgetRef ref,
    List<AppNotification> notifications,
  ) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(isDarkMode
                ? "assets/images/darkmode.jpg"
                : "assets/images/sky.jpg"),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton.icon(
                icon: const Icon(
                  CupertinoIcons.check_mark,
                  color: Colors.white,
                ),
                onPressed: () async {
                  final service = ref.read(notificationStorageServiceProvider);
                  await service.markAllAsRead();
                  ref.invalidate(notificationsProvider);
                  ref.invalidate(unreadCountProvider);
                },
                label: Text(
                  "Mark all as read",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Spacer(),
              TextButton.icon(
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    textStyle:
                        WidgetStatePropertyAll(TextStyle(color: Colors.white))),
                onPressed: () async {
                  final service = ref.read(notificationStorageServiceProvider);
                  await service.clearAllNotifications();
                  ref.invalidate(notificationsProvider);
                  ref.invalidate(unreadCountProvider);
                },
                label: Text(
                  "Delete all",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          verticalGap(10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationItem(
                  context,
                  ref,
                  notifications[index],
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     children: [
          //       const Text(
          //         'Missing notifications?',
          //         style: TextStyle(
          //           fontSize: 14,
          //           color: Colors.black87,
          //         ),
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           // Navigate to historical notifications
          //         },
          //         child: const Text(
          //           'Go to historical notifications.',
          //           style: TextStyle(
          //             fontSize: 14,
          //             color: Colors.blue,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    WidgetRef ref,
    AppNotification notification,
  ) {
    final service = ref.read(notificationStorageServiceProvider);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    String defaultImage =
        "https://images.unsplash.com/photo-1592210454359-9043f067919b?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8d2VhdGhlcnxlbnwwfHwwfHx8MA%3D%3D";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Dismissible(
        key: Key(notification.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          await service.deleteNotification(notification.id);
          ref.invalidate(notificationsProvider);
          ref.invalidate(unreadCountProvider);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification deleted'),
              duration: Duration(seconds: 2),
            ),
          );

          return true;
        },
        background: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   color: Colors.red,
          // ),
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 28,
          ),
        ),
        child: InkWell(
          onTap: () {
            // goRouter.go(AppRoutes.notificationDetails);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 5),
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Hero(
                    tag: notification.id,
                    child: Image.network(
                      notification.imageUrl ?? defaultImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: notification.isRead
                            ? FontWeight.w500
                            : FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('MMM d, yyyy').format(notification.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (!notification.isRead) ...[
                    const SizedBox(width: 4),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.red : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  notification.body,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              onTap: () async {
                if (!notification.isRead) {
                  await service.markAsRead(notification.id);
                  ref.invalidate(notificationsProvider);
                  ref.invalidate(unreadCountProvider);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
