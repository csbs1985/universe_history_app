import 'package:flutter/material.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/login_util.dart';

class LoginEmailComponent extends StatefulWidget {
  const LoginEmailComponent();

  @override
  _LoginEmailComponentState createState() => _LoginEmailComponentState();
}

class _LoginEmailComponentState extends State<LoginEmailComponent> {
  final LoginUtil loginUtil = LoginUtil();
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final TextEditingController emailController = TextEditingController();

  String _labelText = "digite seu email";
  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  loginLabelStyle _labelStyle = loginLabelStyle.NORMAL;
  loginButtonText _buttonText = loginButtonText.VERIFY;

  _keyUp(String _email) {
    setState(() {
      if (_email.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL;
        _labelText = "digite seu email";
      } else {
        _labelStyle = loginLabelStyle.SUCCESS;
        _buttonText = loginButtonText.VERIFY;
        _labelText = "digitando email...";
      }
    });
  }

  void _verify() {
    currentLoginEmail.value = emailController.text;
    currentLoginTypeForm.value = _buttonText;

    if (_buttonText == loginButtonText.VERIFY) return _checkEmail();
    if (_buttonText == loginButtonText.REGISTER)
      currentLogin.value = loginPageType.NAME;
    if (_buttonText == loginButtonText.LOGIN)
      currentLogin.value = loginPageType.PASSWORD;
  }

  void _checkEmail() {
    setState(() {
      if (emailController.text.isEmpty) {
        _labelText = 'informe seu email';
        _labelStyle = loginLabelStyle.WARNING;
        return;
      }
      if (!RegExp(_regx).hasMatch(emailController.text)) {
        _labelText = 'email informado não é válido';
        _labelStyle = loginLabelStyle.WARNING;
        return;
      }

      _labelText = 'verificando email...';
      _labelStyle = loginLabelStyle.SUCCESS;
      _checkEmailEmpty();
    });
  }

  _checkEmailEmpty() async {
    await db
        .getUserEmail(emailController.text)
        .then((result) => {
              setState(() {
                if (result.exists) {
                  _buttonText = loginButtonText.LOGIN;
                  _labelText =
                      'encontrei "${result.children.single.value['name']}", se for você pode entrar!';
                } else {
                  _buttonText = loginButtonText.REGISTER;
                  _labelStyle = loginLabelStyle.WARNING;
                  _labelText = 'email não cadastrado, criar conta!?';
                }
              })
            })
        .catchError(
            (error) => debugPrint('ERROR => _checkEmail: ' + error.toString()));
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
          const TitleComponent(title: 'Qual seu email?'),
          Text(
            _labelText,
            style: loginUtil.getLabelStyle(_labelStyle),
          ),
          const SizedBox(height: UiPadding.medium),
          TextFormField(
            autofocus: true,
            controller: emailController,
            onChanged: (value) => _keyUp(value),
            style: UiTextStyle.text1,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: UiPadding.xLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button3dComponent(
                label: loginUtil.getButtonText(_buttonText),
                size: ButtonSizeEnum.MEDIUM,
                style: ButtonStyleEnum.PRIMARY,
                callback: (value) => _verify(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
