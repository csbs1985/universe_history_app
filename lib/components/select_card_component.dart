// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/justtify_model.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SelectCardComponent extends StatefulWidget {
  const SelectCardComponent(this.content);
  final List<JustifyModel> content;

  @override
  _SelectCustonState createState() => _SelectCustonState();
}

class _SelectCustonState extends State<SelectCardComponent> {
  String isSelected = '0';

  void _setSelected(String id) {
    setState(() {
      isSelected = id;
      print(isSelected);
    });
  }

  bool _getSelected(String id) {
    return isSelected == id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      ? uiButton.selectCardActived
                      : uiButton.selectCard),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
