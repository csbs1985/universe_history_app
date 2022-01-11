// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ButtonDisabledComponent extends StatelessWidget {
  const ButtonDisabledComponent(this.buttonText);
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        buttonText,
        style: uiTextStyle.ButtonDisabled,
      ),
      onPressed: null,
    );
  }
}
