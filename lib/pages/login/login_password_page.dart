import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/login_util.dart';
import 'package:uuid/uuid.dart';

class LoginPasswordComponent extends StatefulWidget {
  const LoginPasswordComponent({Key? key}) : super(key: key);

  @override
  State<LoginPasswordComponent> createState() => _LoginNickPageState();
}

class _LoginNickPageState extends State<LoginPasswordComponent> {
  final AuthService authService = AuthService();
  final LoginUtil loginUtil = LoginUtil();
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final Uuid uuid = const Uuid();

  final passwordController = TextEditingController();

  loginLabelStyle _labelStyle = loginLabelStyle.NORMAL;
  loginButtonText _buttonText = loginButtonText.REGISTER;

  String _labelText = "digite sua senha";
  final String _regx = '[a-z0-9_@*&]';

  bool _showButton = false;
  bool _hiddenPassword = true;

  @override
  initState() {
    super.initState();

    if (currentLoginTypeForm.value == loginButtonText.LOGIN)
      setState(() => _buttonText = loginButtonText.LOGIN);
  }

  _keyUp(String _nick) {
    setState(() {
      _showButton = false;
      if (_nick.isEmpty) {
        _labelStyle = loginLabelStyle.NORMAL;
        _labelText = "digite sua senha";
      } else if (_nick.length < 6) {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = "6 caracteres, no minímo";
      } else {
        _labelStyle = loginLabelStyle.SUCCESS;
        _showButton = true;
        _labelText = currentLoginTypeForm.value == loginButtonText.LOGIN
            ? "senha válida, entrando..."
            : "senha válida, criar conta?";
      }
    });
  }

  void _toggleShow() {
    setState(() => _hiddenPassword = !_hiddenPassword);
  }

  void _pressedButton() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    currentLoginTypeForm.value == loginButtonText.LOGIN
        ? _login()
        : _register();
  }

  void _login() async {
    try {
      await authService.loginAuthentication(
          currentLoginEmail.value, passwordController.text);
      toast.toast(context, ToastEnum.SUCCESS, 'bem vindo de volta.');
    } on AuthException catch (e) {
      setState(() {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = e.message;
      });
      Navigator.of(context).pop();
    }
  }

  void _register() async {
    try {
      await authService.registerAuthentication(
          currentLoginEmail.value, passwordController.text);
      _registerFirestore();
    } on AuthException catch (e) {
      setState(() {
        _labelStyle = loginLabelStyle.WARNING;
        _labelText = e.message;
      });
      Navigator.of(context).pop();
    }
  }

  Future<void> _registerFirestore() async {
    userClass.add({
      'id': authService.user?.uid,
      'date': DateTime.now().toString(),
      'name': currentLoginNick.value,
      'upDateName': '',
      'status': UserStatus.ACTIVE.toString().split('.').last,
      'email': currentLoginEmail.value,
      'channel': 'email',
      'token': authService.token ?? '',
      'isNotification': true,
      'qtyHistory': 0,
      'qtyComment': 0,
    });

    currentDialog.value = 'Criando conta...';

    await db
        .postNewUser(currentUser.value.first)
        .then((result) => {
              ActivityUtil(
                  ActivitiesEnum.NEW_NICKNAME, currentLoginNick.value, ''),
              toast.toast(context, ToastEnum.SUCCESS,
                  '${currentLoginNick.value}, criamos sua conta'),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));

    // await api
    //     .setUser(UserModel.toMap(currentUser.value.first))
    //     .then((result) => {
    //           ActivityUtil(
    //               ActivitiesEnum.NEW_NICKNAME, currentLoginNick.value, ''),
    //           toast.toast(context, ToastEnum.SUCCESS,
    //               '${currentLoginNick.value}, criamos sua conta'),
    //         })
    //     .catchError((error) => debugPrint('ERROR:' + error.toString()));
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
          const TitleComponent(title: 'Qual sua senha?'),
          Text(
            _labelText,
            style: loginUtil.getLabelStyle(_labelStyle),
          ),
          const SizedBox(height: UiPadding.medium),
          TextFormField(
            autofocus: true,
            obscureText: _hiddenPassword,
            controller: passwordController,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(_regx))],
            onChanged: (value) => _keyUp(value),
            style: UiTextStyle.text1,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              counterStyle: TextStyle(fontSize: 0),
            ),
          ),
          const SizedBox(height: UiPadding.xLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button3dComponent(
                label: _hiddenPassword ? 'mostrar' : 'esconder',
                size: ButtonSizeEnum.MEDIUM,
                style: ButtonStyleEnum.SECOND,
                callback: (value) => _toggleShow(),
              ),
              if (_showButton)
                Button3dComponent(
                  label: loginUtil.getButtonText(_buttonText),
                  size: ButtonSizeEnum.MEDIUM,
                  style: ButtonStyleEnum.PRIMARY,
                  callback: (value) => _pressedButton(),
                )
            ],
          )
        ],
      ),
    );
  }
}
