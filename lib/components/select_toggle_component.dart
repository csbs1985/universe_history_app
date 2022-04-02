// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class SelectToggleComponent extends StatefulWidget {
  const SelectToggleComponent({
    required Function callback,
    required String title,
    required String resume,
    required String textOn,
    required String textOff,
    required bool value,
  })  : _title = title,
        _resume = resume,
        _callback = callback,
        _textOn = textOn,
        _textOff = textOff,
        _value = value;

  final Function _callback;
  final String _title;
  final String _resume;
  final String _textOn;
  final String _textOff;
  final bool _value;

  @override
  State<SelectToggleComponent> createState() => _SelectToggleComponentState();
}

class _SelectToggleComponentState extends State<SelectToggleComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleResumeComponent(widget._title, widget._resume),
        FlutterSwitch(
          value: widget._value,
          activeText: widget._textOn,
          inactiveText: widget._textOff,
          activeColor: uiColor.button,
          inactiveColor: uiColor.buttonSecond,
          activeToggleColor: uiColor.buttonBorder,
          inactiveToggleColor: uiColor.buttonSecondBorder,
          activeTextColor: uiColor.buttonLabel,
          inactiveTextColor: uiColor.buttonSecondLabel,
          toggleColor: uiColor.third,
          width: 90,
          height: 30,
          valueFontSize: 12,
          toggleSize: 20,
          borderRadius: 10,
          showOnOff: true,
          onToggle: (value) => widget._callback(value),
        ),
      ],
    );
  }
}
