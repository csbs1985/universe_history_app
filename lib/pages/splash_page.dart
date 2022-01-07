// ignore_for_file: unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: uiColor.first,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 52,
              child: Image.asset(
                uiImages.logo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((_) {
      Navigator.pushNamed(context, '/home', arguments: {});
    });
  }
}
