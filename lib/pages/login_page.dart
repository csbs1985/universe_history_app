// ignore_for_file: avoid_print, unused_local_variable, await_only_futures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_login_component.dart';
import 'package:universe_history_app/components/logo_component.dart';
import 'package:universe_history_app/shared/enums/type_account_login_enum.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void _onPressed(AccountLoginEnum account) {
    setState(() {
      account == AccountLoginEnum.APPLE ? _loginApple() : _loginGoogle();
    });
  }

  void _loginApple() {
    print(AccountLoginEnum.APPLE);
  }

  Future<User?> _loginGoogle() async {
    print(AccountLoginEnum.GOOGLE);

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = await GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      print('SUCCESS: ' + user.toString());
      return user;
    } catch (e) {
      print('ERROR: ' + e.toString());
      return null;
    }
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
              'Entrar ou criar conta',
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
              callback: (value) => _onPressed(value),
            ),
            BtnLoginComponent(
              label: 'Google',
              svg: uiSvg.google,
              account: AccountLoginEnum.GOOGLE,
              callback: (value) => _onPressed(value),
            ),
            const Text(
              'Você deve ter uma conta Apple ou Google para usar os serviços do History.',
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
