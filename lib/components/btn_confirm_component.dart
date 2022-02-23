// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/alertConfirmComponent.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnConfirmComponent extends StatefulWidget {
  const BtnConfirmComponent({
    required Function callback,
    required String title,
    required String text,
    required String link,
    String btnPrimaryLabel = 'Ok',
    String btnSecondaryLabel = 'Cancelar',
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _link = link;

  final Function _callback;
  final String _title;
  final String _text;
  final String _btnPrimaryLabel;
  final String _btnSecondaryLabel;
  final String _link;

  @override
  _BtnConfirmComponentState createState() => _BtnConfirmComponentState();
}

class _BtnConfirmComponentState extends State<BtnConfirmComponent> {
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
            onPressed: () => AlertConfirmComponent(
                title: widget._title,
                text: widget._text,
                link: widget._link,
                btnPrimaryLabel: widget._btnPrimaryLabel,
                btnSecondaryLabel: widget._btnSecondaryLabel,
                callback: (value) => widget._callback(value)),
          ),
        ),
      ),
    );
  }
}
