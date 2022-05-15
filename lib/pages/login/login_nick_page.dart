// ignore_for_file: unused_local_variable, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/login_util.dart';

class LoginNickPage extends StatefulWidget {
  const LoginNickPage({Key? key}) : super(key: key);

  @override
  State<LoginNickPage> createState() => _LoginNickPageState();
}

class _LoginNickPageState extends State<LoginNickPage> {
  final Api api = Api();
  final LoginUtil loginUtil = LoginUtil();

  final nickController = TextEditingController();

  loginLabelStyle _labelStyle = loginLabelStyle.NORMAL;
  loginButtonText _buttonText = loginButtonText.NEXT;

  String _labelText = "digite seu usuário";
  String _regx = '[a-z0-9-_.]';

  bool _showButton = false;

  _keyUp(String _nick) {
    RegExp regExp = RegExp(_regx);

    setState(() {
      if (_nick.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL;
        _labelText = "digite seu usuário";
        _showButton = false;
      } else if (!regExp.hasMatch(_nick)) {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = "veja a cima os caracteres aceitos";
        _showButton = false;
      } else if (_nick.length > 5) {
        api
            .getNickName(_nick)
            .then((result) => {
                  setState(() {
                    if (result.size > 0) {
                      _labelText = 'nome de usuário indisponível';
                      _labelStyle = loginLabelStyle.WARNING;
                      _showButton = false;
                    } else {
                      _labelText = 'nome de usuário disponível, seguir?';
                      _labelStyle = loginLabelStyle.SUCCESS;
                      _showButton = true;
                    }
                  })
                })
            .catchError((error) =>
                debugPrint('WARNING => _checkNickIsEmpty: ' + error));
      } else {
        _labelStyle = loginLabelStyle.SUCCESS;
        _labelText = "digitando usuário...";
        _showButton = false;
      }
    });
  }

  void _next() {
    currentLoginNick.value = nickController.text;
    Navigator.pushNamed(context, '/login-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              uiPadding.large, 0, uiPadding.large, uiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent(title: 'Qual seu nome de usuário?'),
              Text(_labelText, style: loginUtil.getLabelStyle(_labelStyle)),
              const SizedBox(height: uiPadding.medium),
              TextFormField(
                  autofocus: true,
                  controller: nickController,
                  onChanged: (value) => _keyUp(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(_regx))
                  ],
                  style: uiTextStyle.text1,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: uiPadding.xLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_showButton)
                    Button3dComponent(
                        label: loginUtil.getButtonText(_buttonText),
                        size: ButtonSizeEnum.MEDIUM,
                        style: ButtonStyleEnum.PRIMARY,
                        callback: (value) => _next())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
