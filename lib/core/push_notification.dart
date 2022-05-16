// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:http/http.dart' as http;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotification {
  final Api api = Api();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  init() {
    _requestPermission();
    _loadFCM();
    _onMessage();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized)
      print('Usuário concedeu permissão.');
    else if (settings.authorizationStatus == AuthorizationStatus.provisional)
      print('Usuário concedeu permissão provisória.');
    else
      print('Usuário não concedeu permissão ou ignorou a solicitação.');
  }

  void _loadFCM() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void _onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      currentNotification.value = true;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                importance: Importance.high,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navService.pushNamed('/history', args: message.data['id']);
    });
  }

  Future<void> sendNotificationComment(
      String title, String body, String idHistory, String _mencioned) async {
    await api.getTokenOwner(_mencioned).then((result) async {
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAUIaHHec:APA91bGzC9qta9DjF9Z-p16uFv49mfM8uXFo7g7V9EN3rr7wjyvYl9-JSG1m2myxavNpuOjNzbII8lkZjCVYQ9YiaeIctT9Kr0tekihzXeDVWtVtxmy4Y1pqAGIMSEuH7rKOLPAtiZku',
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{'body': body, 'title': title},
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_COMMENT',
                'id': idHistory,
                'status': 'comment'
              },
              "to": result.docs.first['token'],
            },
          ),
        );
      } catch (error) {
        print("ERROR:" + error.toString());
      }
    }).catchError((error) => debugPrint('ERROR:' + error.toString()));
  }
}
