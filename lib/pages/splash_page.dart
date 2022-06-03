// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final UserClass _userClass = UserClass();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _userClass.readUser().then((_user) async {
          if (_user.isNotEmpty) _userClass.setFileUser(_user);

          try {
            await db
                .getUserEmail(currentUser.value.first.email)
                .then((result) => _userClass.add({
                      'id': result.children.single.value['id'],
                      'date': result.children.single.value['date'],
                      'name': result.children.single.value['name'],
                      'upDateName': result.children.single.value['upDateName'],
                      'status': result.children.single.value['status'],
                      'email': result.children.single.value['email'],
                      'token': result.children.single.value['token'],
                      'isNotification':
                          result.children.single.value['isNotification'],
                      'qtyHistory': result.children.single.value['qtyHistory'],
                      'qtyComment': result.children.single.value['qtyComment'],
                    }));
          } on AuthException catch (error) {
            debugPrint('ERROR => getUserEmail: ' + error.toString());
          }
        }).catchError((error) => debugPrint('ERROR => readUser: ' + error));
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
            LogoComponent(
              icon: UiSvg.logo,
              size: 400,
            ),
          ],
        ),
      ),
    );
  }
}
