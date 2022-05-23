// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Api api = Api();
  final UserClass _userClass = UserClass();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _userClass.readUser().then((file) async {
          if (file.isNotEmpty) _userClass.setFileUser(file);
          await api
              .getUser(currentUser.value.first.email)
              .then((result) => _userClass.add(result.docs!.first))
              .catchError((error) => debugPrint('ERROR:' + error.toString()));
          debugPrint('object');
        }).catchError((error) => debugPrint(error));
      }
      Navigator.of(context).pushNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            LogoComponent(icon: UiSvg.logo, size: 400),
          ],
        ),
      ),
    );
  }
}
