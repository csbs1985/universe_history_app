// ignore_for_file: use_key_in_widget_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({
    required String title,
    required String text,
    required String label,
  })  : _title = title,
        _text = text,
        _label = label;

  final String _title;
  final String _text;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 0,
        color: uiColor.comp_3,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _title,
                style: uiTextStyle.header2,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _text,
                style: uiTextStyle.text1,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text(
                  _label,
                  style: uiTextStyle.button1,
                ),
                onPressed: null,
                style: uiButton.button1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
