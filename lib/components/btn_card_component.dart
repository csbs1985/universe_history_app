// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnCardComponent extends StatelessWidget {
  const BtnCardComponent(this.title, this.text);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          onPressed: null,
          style: uiButton.btnCard,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: uiTextStyle.text1,
                ),
                Text(
                  text,
                  style: uiTextStyle.text2,
                ),
              ],
            ),
          )),
    );
  }
}
