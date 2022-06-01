import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/modal/login/components/login_email_component.dart';
import 'package:universe_history_app/modal/login/components/login_name_component.dart';
import 'package:universe_history_app/modal/login/components/login_password_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/utils/login_util.dart';

class LoginPageModal extends StatefulWidget {
  const LoginPageModal({Key? key}) : super(key: key);

  @override
  _LoginPageModalState createState() => _LoginPageModalState();
}

class _LoginPageModalState extends State<LoginPageModal> {
  @override
  void initState() {
    currentLogin.value = loginPageType.EMAIL;
    super.initState();
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
