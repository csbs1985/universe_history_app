// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnPrimaryComponent extends StatefulWidget {
  const BtnPrimaryComponent({
    Function? callback,
    required String label,
    bool enabled = true,
  })  : _callback = callback,
        _label = label,
        _enabled = enabled;

  final Function? _callback;
  final String _label;
  final bool _enabled;

  @override
  _BtnPrimaryComponentState createState() => _BtnPrimaryComponentState();
}

class _BtnPrimaryComponentState extends State<BtnPrimaryComponent> {
  void _onPressed(bool pressed) {
    setState(() {
      widget._callback!(pressed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: widget._enabled
          ? uiButton.buttonPrimary
          : uiButton.buttonPrimaryDisabled,
      child: Text(
        widget._label,
        style: widget._enabled ? uiTextStyle.text1 : uiTextStyle.text5,
      ),
      onPressed: () => widget._enabled ? _onPressed(true) : null,
    );
  }
}
