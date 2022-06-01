import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

ValueNotifier<String> currentLogin = ValueNotifier<String>('email');
ValueNotifier<String> currentLoginEmail = ValueNotifier<String>('');
ValueNotifier<String> currentLoginNick = ValueNotifier<String>('');
ValueNotifier<String> currentLoginPassword = ValueNotifier<String>('');
ValueNotifier<loginButtonText> currentLoginTypeForm =
    ValueNotifier<loginButtonText>(loginButtonText.REGISTER);

class LoginUtil {
  TextStyle getLabelStyle(loginLabelStyle _value) {
    if (_value == loginLabelStyle.SUCCESS) return UiTextStyle.loginLabelSuccess;
    if (_value == loginLabelStyle.WARNING) return UiTextStyle.loginLabelError;
    return UiTextStyle.loginLabel;
  }

  String getButtonText(loginButtonText _value) {
    if (_value == loginButtonText.LOGIN) return 'entrar';
    if (_value == loginButtonText.REGISTER) return 'criar';
    if (_value == loginButtonText.NEXT) return 'seguir';
    return 'verificar';
  }
}

enum loginLabelStyle { WARNING, SUCCESS, NORMAL }
enum loginButtonText { VERIFY, REGISTER, LOGIN, NEXT }
