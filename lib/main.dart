// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/pages/create_history_page.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/pages/notification_page.dart';
import 'package:universe_history_app/pages/privacy_page.dart';
import 'package:universe_history_app/pages/settings_page.dart';
import 'package:universe_history_app/pages/splash_page.dart';
import 'package:universe_history_app/pages/terms_page.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: uiColor.second,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.second,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: uiTheme.theme1,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
                child: const HomePage(),
                type: PageTransitionType.fade,
                settings: settings);
          case '/create':
            return PageTransition(
                child: const CreateHistory(),
                type: PageTransitionType.bottomToTop,
                settings: settings);
          case '/settings':
            return PageTransition(
                child: const SettingsPage(),
                type: PageTransitionType.topToBottom,
                settings: settings);
          case '/notification':
            return PageTransition(
                child: const NotificationPage(),
                type: PageTransitionType.topToBottom,
                settings: settings);
          case '/privacy':
            return PageTransition(
                child: const PrivacyPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/terms':
            return PageTransition(
                child: const TermsPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          default:
            return null;
        }
      },
    );
  }
}
