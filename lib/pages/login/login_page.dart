import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/utils/login_util.dart';
import 'login_email_component.dart';
import 'login_name_component.dart';
import 'login_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    currentLogin.value = loginPageType.EMAIL;
  }

  @override
  void dispose() {
    setState(() {
      currentLogin.value = loginPageType.EMAIL;
      currentLoginEmail.value = '';
      currentLoginNick.value = '';
      currentLoginPassword.value = '';
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: UiColor.comp_1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarBackComponent(),
            ValueListenableBuilder(
              valueListenable: currentLogin,
              builder: (context, value, __) {
                return Column(
                  children: [
                    if (currentLogin.value == loginPageType.EMAIL)
                      const LoginEmailComponent(),
                    if (currentLogin.value == loginPageType.NAME)
                      const LoginNameComponent(),
                    if (currentLogin.value == loginPageType.PASSWORD)
                      const LoginPasswordComponent(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
