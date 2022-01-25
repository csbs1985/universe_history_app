// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnComponent extends StatefulWidget {
  const BtnComponent(
      {Function? callback, String label = "publicar", bool enabled = true})
      : _callback = callback,
        _label = label,
        _enabled = enabled;

  final Function? _callback;
  final String _label;
  final bool _enabled;

  @override
  _BtnComponentState createState() => _BtnComponentState();
}

class _BtnComponentState extends State<BtnComponent> {
  void _onPressed() {
    widget._callback!(true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Text(
          widget._label,
          style:
              widget._enabled ? uiTextStyle.button2 : uiTextStyle.btnDisabled,
        ),
        onPressed: () => widget._enabled ? _onPressed() : null,
      ),
    );
  }
}
