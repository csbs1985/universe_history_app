// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universe_history_app/core/api.dart';

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
      print('Usuário não deu permissão ou ignorou a solicitação.');
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
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void getToken() async {
    await api.getToken().then((_token) {
      api.setToken(_token);
    }).catchError((error) => print('ERROR:' + error.toString()));
  }
}
