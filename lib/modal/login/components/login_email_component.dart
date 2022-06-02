import 'package:flutter/material.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/modal/login/login_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginEmailComponent extends StatefulWidget {
  const LoginEmailComponent();

  @override
  _LoginEmailComponentState createState() => _LoginEmailComponentState();
}

class _LoginEmailComponentState extends State<LoginEmailComponent> {
  final LoginClass loginClass = LoginClass();
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final TextEditingController emailController = TextEditingController();

  String _labelText = "digite seu email";
  final String _regx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String _labelStyle = loginLabelStyle.NORMAL.name;
  String _buttonText = loginButtonText.VERIFY.name;

  _keyUp(String _email) {
    setState(() {
      if (_email.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL.name;
        _labelText = "digite seu email";
      } else {
        _labelStyle = loginLabelStyle.SUCCESS.name;
        _buttonText = loginButtonText.VERIFY.name;
        _labelText = "digitando email...";
      }
    });
  }

  void _verify() {
    currentLoginEmail.value = emailController.text;
    currentLoginButton.value = _buttonText;

    if (_buttonText == loginButtonText.VERIFY.name) return _checkEmail();
    if (_buttonText == loginButtonText.REGISTER.name) {
      currentLoginType.value = loginPageType.NAME.name;
      return;
    }
    if (_buttonText == loginButtonText.LOGIN.name) {
      currentLoginType.value = loginPageType.PASSWORD.name;
      return;
    }
  }

  void _checkEmail() {
    setState(() {
      if (emailController.text.isEmpty) {
        _labelText = 'informe seu email';
        _labelStyle = loginLabelStyle.WARNING.name;
        return;
      }
      if (!RegExp(_regx).hasMatch(emailController.text)) {
        _labelText = 'email informado não é válido';
        _labelStyle = loginLabelStyle.WARNING.name;
        return;
      }

      _labelText = 'verificando email...';
      _labelStyle = loginLabelStyle.SUCCESS.name;
      _checkEmailEmpty();
    });
  }

  _checkEmailEmpty() async {
    await db
        .getUserEmail(emailController.text)
        .then((result) => {
              setState(() {
                if (result.exists) {
                  _buttonText = loginButtonText.LOGIN.name;
                  _labelText =
                      'encontrei "${result.children.single.value['name']}", se for você pode entrar!';
                } else {
                  _buttonText = loginButtonText.REGISTER.name;
                  _labelStyle = loginLabelStyle.WARNING.name;
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
            style: loginClass.getLabelStyle(_labelStyle),
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
                label: loginClass.getButtonText(_buttonText),
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
