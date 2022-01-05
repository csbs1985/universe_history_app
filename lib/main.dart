import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        statusBarColor: uiColor.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: uiColor.comp_5,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SplashPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: uiColor.primary,
        fontFamily: 'ubuntu',
        appBarTheme: const AppBarTheme(
          backgroundColor: uiColor.primary,
          elevation: 0,
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(
                child: const HomePage(),
                type: PageTransitionType.fade,
                settings: settings);
          default:
            return null;
        }
      },
    );
  }
}
