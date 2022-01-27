import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_login_component.dart';
import 'package:universe_history_app/shared/models/enums/type_account_login_enum.dart';
import 'package:universe_history_app/theme/ui_image.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _onPressed(AccountLoginEnum account) {
    setState(() {
      account == AccountLoginEnum.APPLE ? _loginApple() : _loginGoogle();
    });
  }

  void _loginApple() {
    print(AccountLoginEnum.APPLE);
  }

  void _loginGoogle() {
    print(AccountLoginEnum.GOOGLE);
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset(
                  uiImage.logo,
                  fit: BoxFit.fitWidth,
                ),
              ),
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
