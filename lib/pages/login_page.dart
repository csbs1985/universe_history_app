// ignore_for_file: avoid_print, unused_local_variable, await_only_futures

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
  void _loginApple() {
    print(AccountLoginEnum.APPLE);
  }

  void _loginGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

    await _googleSignIn.signIn();
    try {
      print('SUCCESS: ' + currentUser.toString());
    } catch (e) {
      print('ERROR: ' + e.toString());
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
