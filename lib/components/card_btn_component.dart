// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CardBtnComponent extends StatefulWidget {
  const CardBtnComponent(
      {Function? callback, required String label, required String icon})
      : _callback = callback,
        _label = label,
        _icon = icon;

  final Function? _callback;
  final String _label;
  final String _icon;

  @override
  State<CardBtnComponent> createState() => _CardBtnComponentState();
}

class _CardBtnComponentState extends State<CardBtnComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: uiColor.comp_1,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF0d1117),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: SvgPicture.asset(widget._icon),
            ),
            const SizedBox(height: 16),
            Text(
              widget._label,
              style: uiTextStyle.header1,
            ),
          ],
        ),
      ),
      onTap: () => widget._callback!(true),
    );
  }
}
