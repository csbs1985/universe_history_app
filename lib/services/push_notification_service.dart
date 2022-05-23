import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/route.dart';
import 'package:universe_history_app/services/local_notification_service.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  final Api api = Api();

  final LocalNotificationService _notificationService;

  PushNotificationService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: false,
      alert: true,
    );

    _onMessage();
    _onMessageOpenedApp();
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notificationService.showNotification(CustomNotification(
            title: notification.title!,
            body: notification.body!,
            payload: message.data['id']));
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    if (message.data['payload'] != null && message.data['payload'].isNotEmpty) {
      Routes.navigatorKey?.currentState
          ?.pushNamed('/history', arguments: message.data['payload']);
    }
  }

  Future<void> sendNotification(
      String title, String body, String idHistory, String _user) async {
    await api.getTokenOwner(_user).then((result) async {
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAUIaHHec:APA91bGzC9qta9DjF9Z-p16uFv49mfM8uXFo7g7V9EN3rr7wjyvYl9-JSG1m2myxavNpuOjNzbII8lkZjCVYQ9YiaeIctT9Kr0tekihzXeDVWtVtxmy4Y1pqAGIMSEuH7rKOLPAtiZku',
          },
          body: jsonEncode(
            {
              "to": result.docs.first['token'],
              'priority': 'high',
              'notification': {
                'title': title,
                'body': body,
                'click_action': 'FLUTTER_NOTIFICATION_COMMENT',
                'android': '',
                'ios': '',
              },
              'data': {
                'id': idHistory,
              },
              "android": {
                "direct_boot_ok": true,
              },
            },
          ),
        );
      } catch (error) {
        debugPrint("ERROR:" + error.toString());
      }
    }).catchError((error) => debugPrint('ERROR:' + error.toString()));
  }
}
