// @dart=2.9
// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universe_history_app/core/navigation.dart';
import 'package:universe_history_app/pages/splash_page.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: uiColor.comp_1,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.comp_1,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: uiTheme.theme1,
      onGenerateRoute: Navigation.generateRoute,
    );
  }
}
