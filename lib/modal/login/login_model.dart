import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

ValueNotifier<String> currentLoginEmail = ValueNotifier<String>('');
ValueNotifier<String> currentLoginName = ValueNotifier<String>('');
ValueNotifier<String> currentLoginPassword = ValueNotifier<String>('');
ValueNotifier<String> currentLoginButton = ValueNotifier<String>('');
ValueNotifier<String> currentLoginType = ValueNotifier<String>('');

class LoginClass {
  void clean() {
    currentLoginEmail.value = '';
    currentLoginName.value = '';
    currentLoginPassword.value = '';
    currentLoginButton.value = loginButtonText.VERIFY.name;
    currentLoginType.value = loginPageType.EMAIL.name;
  }

  TextStyle getLabelStyle(String _value) {
    if (_value == loginLabelStyle.SUCCESS.name)
      return UiTextStyle.loginLabelSuccess;
    if (_value == loginLabelStyle.WARNING.name)
      return UiTextStyle.loginLabelError;
    return UiTextStyle.loginLabel;
  }

  String getButtonText(String _value) {
    if (_value == loginButtonText.LOGIN.name) return 'entrar';
    if (_value == loginButtonText.REGISTER.name) return 'criar';
    if (_value == loginButtonText.NEXT.name) return 'seguir';
    return 'verificar';
  }
}

enum loginPageType { EMAIL, PASSWORD, NAME }
enum loginLabelStyle { WARNING, SUCCESS, NORMAL }
enum loginButtonText { VERIFY, REGISTER, LOGIN, NEXT }
