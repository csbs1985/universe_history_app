// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/shared/enums/type_account_login_enum.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnLoginComponent extends StatefulWidget {
  BtnLoginComponent({
    Function? callback,
    required String label,
    required String svg,
    required AccountLoginEnum account,
  })  : _callback = callback,
        _label = label,
        _svg = svg,
        _account = account;

  Function? _callback;
  String _label;
  String _svg;
  AccountLoginEnum _account;

  @override
  _BtnLoginComponentState createState() => _BtnLoginComponentState();
}

class _BtnLoginComponentState extends State<BtnLoginComponent> {
  void _onPressed(AccountLoginEnum id) {
    setState(() {
      widget._callback!(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          width: double.infinity,
          child: TextButton.icon(
            icon: SvgPicture.asset(widget._svg),
            onPressed: () => _onPressed(widget._account),
            label: Text(
              'Use sua conta ' + widget._label,
              style: uiTextStyle.text1,
            ),
            style: uiButton.btnLogin,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
