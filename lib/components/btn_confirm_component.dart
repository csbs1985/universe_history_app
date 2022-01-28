// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnConfirmComponent extends StatefulWidget {
  const BtnConfirmComponent({
    required String title,
    required String text,
    required String link,
    Function? callback,
    String? btnPrimaryLabel = 'Ok',
    String? btnSecondaryLabel = 'Cancelar',
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _link = link;

  final Function? _callback;
  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;
  final String _link;

  @override
  _BtnLinkComponentState createState() => _BtnLinkComponentState();
}

class _BtnLinkComponentState extends State<BtnConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 10),
      child: Material(
        color: uiColor.comp_1,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget._title,
                style: uiTextStyle.text1,
              ),
            ),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () => _showAlertConfirm(
              context,
              widget._title,
              widget._text,
              widget._link,
              widget._btnPrimaryLabel,
              widget._btnSecondaryLabel,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Future> _showAlertConfirm(
    BuildContext context,
    String title,
    String text,
    String link,
    String? _btnPrimaryLabel,
    String? _btnSecondaryLabel) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: uiColor.comp_1,
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: Text(
                    _btnSecondaryLabel!,
                    style: uiTextStyle.text3,
                  ),
                ),
                TextButton(
                  style: uiButton.button1,
                  child: Text(
                    _btnPrimaryLabel!,
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
