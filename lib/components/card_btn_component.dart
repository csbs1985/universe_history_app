// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CardBtnComponent extends StatefulWidget {
  const CardBtnComponent({
    required Function callback,
    required String label,
    required String text,
  })  : _callback = callback,
        _label = label,
        _text = text;

  final Function _callback;
  final String _label;
  final String _text;

  @override
  State<CardBtnComponent> createState() => _CardBtnComponentState();
}

class _CardBtnComponentState extends State<CardBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0d1117),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget._text,
            style: uiTextStyle.header2,
          ),
          Button3dComponent(
              callback: (value) => widget._callback(true), label: widget._label)
        ],
      ),
    );
  }
}
