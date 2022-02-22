// ignore_for_file: use_key_in_widget_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CardComponent extends StatefulWidget {
  const CardComponent({
    Function? callback,
    required String title,
    required String text,
  })  : _title = title,
        _text = text,
        _callback = callback;

  final Function? _callback;
  final String _title;
  final String _text;

  @override
  _CardComponentState createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  void _onPressed() {
    setState(() {
      widget._callback!(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget._title.toUpperCase(),
              style: uiTextStyle.text9,
            ),
            Text(
              widget._text.toUpperCase(),
              style: uiTextStyle.header4,
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              uiSvg.open,
              color: uiColor.first,
            ),
          ],
        ),
        onTap: () => _onPressed(),
      ),
    );
  }
}
