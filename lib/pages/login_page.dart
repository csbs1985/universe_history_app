// ignore_for_file: avoid_print, unused_local_variable, await_only_futures, unused_field, unnecessary_new, deprecated_member_use

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_login_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/enums/type_account_login_enum.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ToastComponent toast = new ToastComponent();
  final CurrentUser _user = CurrentUser();
  final Api api = Api();

  late Map<String, dynamic> _form;

  void _loginApple() {
    print(AccountLoginEnum.APPLE);
  }

  Future<User?> _loginGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = authResult.user!;

      _verifyUser('google', user);
      Navigator.of(context).pop();

      return user;
    } catch (e) {
      print('ERROR: ' + e.toString());
      toast.toast(context, ToastEnum.WARNING, 'ERROR: ' + e.toString());
      return null;
    }
  }

  void _verifyUser(String channel, User user) {
    api
        .getUser(user.email)
        .then((result) => {
              if (result.docs.isNotEmpty)
                {
                  _user.add(result.docs.first.data()),
                }
              else
                {
                  _form = {
                    'id': user.uid,
                    'date': DateTime.now(),
                    'nickname': user.displayName,
                    'isDisabled': false,
                    'email': user.email,
                    'channel': channel
                  },
                  api.setUser(_form, user.uid).then(
                    (result) {
                      _user.add(result.docs.first.data());
                    },
                  ),
                }
            })
        .catchError((error) {
      print('ERROR:' + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: LogoComponent(
                icon: uiSvg.logo,
                size: 400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Entrar ou criar conta History',
              style: uiTextStyle.text1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            BtnLoginComponent(
              label: 'Apple',
              svg: uiSvg.apple,
              account: AccountLoginEnum.APPLE,
              callback: (value) => _loginApple(),
            ),
            BtnLoginComponent(
              label: 'Google',
              svg: uiSvg.google,
              account: AccountLoginEnum.GOOGLE,
              callback: (value) => _loginGoogle(),
            ),
            const Text(
              'Você deve ter uma conta Apple ou Google para utilizar os serviços do History.',
              style: uiTextStyle.text1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  ' Leia o ',
                  style: uiTextStyle.text2,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed("/terms"),
                  child: const Text(
                    'Termo de uso',
                    style: uiTextStyle.text6,
                  ),
                ),
                const Text(
                  ' e ',
                  style: uiTextStyle.text2,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed("/privacy"),
                  child: const Text(
                    'Política de privacidade',
                    style: uiTextStyle.text6,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
