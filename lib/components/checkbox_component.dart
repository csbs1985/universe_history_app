// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/checkbox.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CheckboxCuston extends StatefulWidget {
  const CheckboxCuston(this.title, this.content);
  final String title;
  final List<CheckboxModel> content;

  @override
  _CheckboxCustonState createState() => _CheckboxCustonState();
}

class _CheckboxCustonState extends State<CheckboxCuston> {
  int isSelected = 0;

  void _setSelected(int id) {
    setState(() {
      isSelected = id;
      print(isSelected);
    });
  }

  bool _getSelected(int id) {
    return isSelected == id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: uiTextStyle.header2,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in widget.content)
              TextButton(
                  child: Text(
                    item.label,
                    style: _getSelected(item.id)
                        ? uiTextStyle.active
                        : uiTextStyle.chips,
                  ),
                  onPressed: () => _setSelected(item.id),
                  style: _getSelected(item.id)
                      ? ButtonsTheme.active
                      : ButtonsTheme.chips),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
