import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/pages/create_history.dart';
import 'package:universe_history_app/pages/home_page.dart';
import 'package:universe_history_app/pages/splash_page.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      title: 'Flutter Demo',
      home: const SplashPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: uiColor.second,
        fontFamily: 'roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: uiColor.second,
          elevation: 0,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: uiColor.first,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
                child: HomePage(),
                type: PageTransitionType.fade,
                settings: settings);
          case '/create':
            return PageTransition(
                child: CreateHistory(),
                type: PageTransitionType.bottomToTop,
                settings: settings);
          default:
            return null;
        }
      },
    );
  }
}
