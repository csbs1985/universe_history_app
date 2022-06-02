import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/modal/login/login_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginNameComponent extends StatefulWidget {
  const LoginNameComponent({Key? key}) : super(key: key);

  @override
  State<LoginNameComponent> createState() => _LoginNameComponentState();
}

class _LoginNameComponentState extends State<LoginNameComponent> {
  final LoginClass loginClass = LoginClass();
  final RealtimeDatabaseService db = RealtimeDatabaseService();

  final nickController = TextEditingController();

  String _labelStyle = loginLabelStyle.NORMAL.name;
  final String _buttonText = loginButtonText.NEXT.name;

  String _labelText = "digite seu usuário";
  final String _regx = '[a-z0-9-_.]';

  bool _showButton = false;

  _keyUp(String _nick) {
    RegExp regExp = RegExp(_regx);

    setState(() {
      if (_nick.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL.name;
        _labelText = "digite seu usuário";
        _showButton = false;
      } else if (!regExp.hasMatch(_nick)) {
        _labelStyle = loginLabelStyle.WARNING.name;
        _labelText = "veja a cima os caracteres aceitos";
        _showButton = false;
      } else if (_nick.length > 5) {
        _checkNameEmpty(_nick);
      } else {
        _labelStyle = loginLabelStyle.SUCCESS.name;
        _labelText = "digitando usuário...";
        _showButton = false;
      }
    });
  }

  _checkNameEmpty(String _nick) async {
    await db
        .getUserName(_nick)
        .then((result) => {
              setState(() {
                if (result.exists) {
                  _labelText = 'nome de usuário indisponível';
                  _labelStyle = loginLabelStyle.WARNING.name;
                  _showButton = false;
                } else {
                  _labelText = 'nome de usuário disponível, seguir?';
                  _labelStyle = loginLabelStyle.SUCCESS.name;
                  _showButton = true;
                }
              })
            })
        .catchError(
            (error) => debugPrint('ERROR => _checkEmail: ' + error.toString()));
  }

  void _next() {
    currentLoginName.value = nickController.text;
    currentLoginType.value = loginPageType.PASSWORD.name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        UiPadding.large,
        0,
        UiPadding.large,
        UiPadding.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleComponent(title: 'Qual seu nome de usuário?'),
          Text(
            _labelText,
            style: loginClass.getLabelStyle(_labelStyle),
          ),
          const SizedBox(height: UiPadding.medium),
          TextFormField(
            autofocus: true,
            maxLength: 20,
            controller: nickController,
            onChanged: (value) => _keyUp(value),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(_regx))],
            style: UiTextStyle.text1,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              counterStyle: TextStyle(fontSize: 0),
            ),
          ),
          const SizedBox(height: UiPadding.xLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_showButton)
                Button3dComponent(
                  label: loginClass.getButtonText(_buttonText),
                  size: ButtonSizeEnum.MEDIUM,
                  style: ButtonStyleEnum.PRIMARY,
                  callback: (value) => _next(),
                )
            ],
          )
        ],
      ),
    );
  }
}
