import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/modal/login/components/login_email_component.dart';
import 'package:universe_history_app/modal/login/components/login_name_component.dart';
import 'package:universe_history_app/modal/login/components/login_password_component.dart';
import 'package:universe_history_app/modal/login/login_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({Key? key}) : super(key: key);

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: UiColor.comp_1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarBackComponent(),
            ValueListenableBuilder(
              valueListenable: currentLoginType,
              builder: (context, value, __) {
                return Column(
                  children: [
                    if (currentLoginType.value == loginPageType.EMAIL.name)
                      const LoginEmailComponent(),
                    if (currentLoginType.value == loginPageType.NAME.name)
                      const LoginNameComponent(),
                    if (currentLoginType.value == loginPageType.PASSWORD.name)
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
