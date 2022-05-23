// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnLinkComponent extends StatefulWidget {
  const BtnLinkComponent(this.text, this.link);

  final String text;
  final String link;

  @override
  _BtnLinkComponentState createState() => _BtnLinkComponentState(text, link);
}

class _BtnLinkComponentState extends State<BtnLinkComponent> {
  _BtnLinkComponentState(this.text, this.link);

  final String text;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: TextButton(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: uiTextStyle.text1,
            ),
          ),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => Navigator.of(context).pushNamed(link),
        ),
      ),
    );
  }
}
