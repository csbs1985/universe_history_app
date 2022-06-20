import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universe_history_app/core/route.dart';

class LocalNotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late IOSNotificationDetails appleDetails;

  LocalNotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const apple = IOSInitializationSettings();

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: apple,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.pushNamed(Routes.navigatorKey!.currentContext!, '/history',
          arguments: payload);
    }
  }

  showNotification(CustomNotification notification, {String? user}) {
    androidDetails = const AndroidNotificationDetails(
      'high_importance_channel',
      'Notificações',
      channelDescription: 'canal de notificação',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      playSound: true,
    );

    appleDetails = const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: appleDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp)
      _onSelectNotification(details.payload);
  }
}

class CustomNotification {
  late int id;
  late String title;
  late String body;
  late String payload;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
