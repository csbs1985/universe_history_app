// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:text_transformation_animation/text_transformation_animation.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/push_notification.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/login_util.dart';
import 'package:uuid/uuid.dart';

class LoginPasswordPage extends StatefulWidget {
  const LoginPasswordPage({Key? key}) : super(key: key);

  @override
  State<LoginPasswordPage> createState() => _LoginNickPageState();
}

class _LoginNickPageState extends State<LoginPasswordPage> {
  final Api api = Api();
  final LoginUtil loginUtil = LoginUtil();
  final PushNotification notification = PushNotification();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final Uuid uuid = const Uuid();

  final passwordController = TextEditingController();

  loginLabelStyle _labelStyle = loginLabelStyle.NORMAL;
  loginButtonText _buttonText = loginButtonText.REGISTER;

  String _labelText = "digite sua senha";
  String _regx = '[a-z0-9-_.@*&]';

  bool _isButtonDisabled = true;
  bool _showPassword = false;

  _keyUp(String _nick) {
    setState(() {
      _isButtonDisabled = true;
      if (_nick.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL;
        _labelText = "digite sua senha";
      } else if (_nick.length < 6) {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = "6 caracteres, no minímo";
      } else {
        _labelStyle = loginLabelStyle.SUCCESS;
        _labelText = "senha válida, criar conta?";
        _isButtonDisabled = false;
      }
    });
  }

  void _toggleShow() {
    setState(() => _showPassword = !_showPassword);
  }

  void _register() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    try {
      await context.read<AuthService>().registerAuthentication(
          currentLoginEmail.value, passwordController.text);
      notification.getToken();
      _registerFirestore();
    } on AuthException catch (e) {
      Navigator.of(context).pop();
      setState(() {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = e.message;
      });
    }
  }

  Future<void> _registerFirestore() async {
    // qj9vVwxNvzPwa3AU1jeLLmCb5qI3
    context.read<AuthService>().auth.currentUser!.uid;

    userClass.add({
      'id': context.read<AuthService>().auth.currentUser!.uid,
      'date': DateTime.now().toString(),
      'nickname': currentLoginNick.value,
      'upDateNickname': '',
      'status': UserStatus.ACTIVE.toString().split('.').last,
      'email': currentLoginEmail.value,
      'channel': 'email',
      'token': currentToken.value,
      'isNotification': true,
      'qtyHistory': 0,
      'qtyComment': 0,
    });

    currentDialog.value = 'Criando conta...';

    await api
        .setUser(UserModel.toMap(currentUser.value.first))
        .then((result) => {
              ActivityUtil(
                  ActivitiesEnum.NEW_NICKNAME, currentLoginNick.value, ''),
              toast.toast(context, ToastEnum.SUCCESS,
                  '${currentLoginNick.value}, criamos sua conta'),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
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
              const TitleComponent(title: 'Qual sua senha?'),
              TextTransformationAnimation(
                  text: _labelText,
                  style: loginUtil.getLabelStyle(_labelStyle),
                  duration: const Duration(milliseconds: 150)),
              const SizedBox(height: uiPadding.medium),
              TextFormField(
                  autofocus: true,
                  obscureText: _showPassword,
                  controller: passwordController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(_regx))
                  ],
                  onChanged: (value) => _keyUp(value),
                  style: uiTextStyle.text1,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: uiPadding.xLarge),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Button3dComponent(
                    label: 'mostrar',
                    size: ButtonSizeEnum.MEDIUM,
                    style: ButtonStyleEnum.SECOND,
                    callback: (value) => _toggleShow()),
                Button3dComponent(
                    label: loginUtil.getButtonText(_buttonText),
                    size: ButtonSizeEnum.MEDIUM,
                    style: _isButtonDisabled
                        ? ButtonStyleEnum.DISABLED
                        : ButtonStyleEnum.PRIMARY,
                    callback: (value) => _register())
              ])
            ],
          ),
        ),
      ),
    );
  }
}
