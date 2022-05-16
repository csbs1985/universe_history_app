// @dart=2.9
// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/core/navigation.dart';
import 'package:universe_history_app/core/push_notification.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/pages/splash_page.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => AuthService())],
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final PushNotification _notification = PushNotification();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: uiColor.comp_1,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.comp_1,
        systemNavigationBarIconBrightness: Brightness.light));

    _notification.init();

    return MaterialApp(
        navigatorKey: NavigationService.navigationKey,
        debugShowCheckedModeBanner: false,
        theme: uiTheme.theme1,
        onGenerateRoute: Navigation.generateRoute,
        home: const SplashPage());
  }
}
