// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ToggleComponent extends StatefulWidget {
  const ToggleComponent({
    required Function callback,
    required bool value,
  })  : _callback = callback,
        _value = value;

  final Function _callback;
  final bool _value;

  @override
  State<ToggleComponent> createState() => _ToggleComponentState();
}

class _ToggleComponentState extends State<ToggleComponent> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 48,
      height: 32,
      value: widget._value,
      activeColor: uiColor.button,
      inactiveColor: uiColor.buttonSecond,
      activeToggleColor: uiColor.buttonBorder,
      inactiveToggleColor: uiColor.buttonSecondBorder,
      activeTextColor: uiColor.buttonLabel,
      inactiveTextColor: uiColor.buttonSecondLabel,
      toggleSize: 20,
      onToggle: (value) => widget._callback(value),
    );
  }
}
