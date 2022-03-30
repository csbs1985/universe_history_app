// ignore_for_file: use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, constant_identifier_names

import 'package:button3d/button3d.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class Button3dComponent extends StatefulWidget {
  const Button3dComponent({
    required Function callback,
    required String label,
    ButtonEnum? style,
  })  : _callback = callback,
        _label = label,
        _style = style;

  final Function _callback;
  final String _label;
  final ButtonEnum? _style;

  @override
  _Button3dComponentState createState() => _Button3dComponentState();
}

class _Button3dComponentState extends State<Button3dComponent> {
  Color topColor = uiColor.button;
  Color backColor = uiColor.buttonBorder;
  TextStyle text = uiTextStyle.buttonLabel;

  @override
  void initState() {
    super.initState();

    if (widget._style == ButtonEnum.SECOND) {
      topColor = uiColor.buttonSecond;
      backColor = uiColor.buttonSecondBorder;
      text = uiTextStyle.buttonSecondLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button3d(
      height: 42,
      onPressed: () => widget._callback(true),
      child: Text(
        widget._label,
        style: text,
      ),
      style: Button3dStyle(
        z: 4,
        topColor: topColor,
        backColor: backColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

enum ButtonEnum {
  DISABLED,
  SECOND,
  PRIMARY,
}
