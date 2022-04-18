import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ButtonOptionComponent extends StatefulWidget {
  const ButtonOptionComponent({
    required Function callback,
    required String label,
    required String icon,
  })  : _callback = callback,
        _label = label,
        _icon = icon;

  final Function _callback;
  final String _label;
  final String _icon;

  @override
  State<ButtonOptionComponent> createState() => _ButtonOptionComponentState();
}

class _ButtonOptionComponentState extends State<ButtonOptionComponent> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => widget._callback(true),
      icon: SvgPicture.asset(widget._icon),
      label: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          ' ' + widget._label,
          style: uiTextStyle.text1,
        ),
      ),
    );
  }
}
