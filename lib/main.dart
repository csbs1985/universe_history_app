// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/pages/about_page.dart';
import 'package:universe_history_app/pages/blocked_users_page.dart';
import 'package:universe_history_app/pages/common_questions_page.dart';
import 'package:universe_history_app/pages/create_history_page.dart';
import 'package:universe_history_app/pages/delete_account_page.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/pages/justify_page.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          case '/home':
            return PageTransition(
                child: const HomePage(),
                type: PageTransitionType.fade,
                settings: settings);
          case '/about':
            return PageTransition(
                child: const AboutPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/blocked':
            return PageTransition(
                child: const blockedUsersPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/create':
            return PageTransition(
                child: const CreateHistory(),
                type: PageTransitionType.bottomToTop,
                settings: settings);
          case '/delete-account':
            return PageTransition(
                child: const DeleteAccountPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/justify':
            return PageTransition(
                child: const JustifyPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/notification':
            return PageTransition(
                child: const NotificationPage(),
                type: PageTransitionType.topToBottom,
                settings: settings);
          case '/questions':
            return PageTransition(
                child: CommonQuestionsPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/privacy':
            return PageTransition(
                child: const PrivacyPage(),
                type: PageTransitionType.rightToLeft,
                settings: settings);
          case '/settings':
            return PageTransition(
                child: const SettingsPage(),
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
