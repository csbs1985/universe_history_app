// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnIconComponent extends StatefulWidget {
  const BtnIconComponent(
      {Function? callback, required String label, required String icon})
      : _callback = callback,
        _label = label,
        _icon = icon;

  final Function? _callback;
  final String _label;
  final String _icon;

  @override
  State<BtnIconComponent> createState() => _BtnIconComponentState();
}

class _BtnIconComponentState extends State<BtnIconComponent> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        widget._label,
        style: uiTextStyle.header2,
      ),
      style: uiButton.buttonPrimary,
      icon: SvgPicture.asset(widget._icon),
      onPressed: () => widget._callback!(true),
    );
  }
}
