// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnConfirmComponent extends StatefulWidget {
  const BtnConfirmComponent(this.title, this.text, this.link);

  final String title;
  final String text;
  final String link;

  @override
  _BtnLinkComponentState createState() =>
      _BtnLinkComponentState(title, text, link);
}

class _BtnLinkComponentState extends State<BtnConfirmComponent> {
  _BtnLinkComponentState(this.title, this.text, this.link);

  final String title;
  final String text;
  final String link;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: uiColor.second,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: uiTextStyle.text1,
            ),
          ),
        ),
      ),
      onTap: () => _showAlertConfirm(context, title, text, link),
    );
  }
}

Future<Future> _showAlertConfirm(
    BuildContext context, String title, String text, String link) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: uiColor.second,
        title: Text(
          title,
          style: uiTextStyle.text5,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(
                text,
                style: uiTextStyle.text1,
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: const Text(
                    'Deletar',
                    style: uiTextStyle.text3,
                  ),
                ),
                TextButton(
                  style: uiButton.button1,
                  child: const Text(
                    'Cancelar',
                    style: uiTextStyle.text1,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
