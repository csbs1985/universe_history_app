// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_import, unused_field, avoid_web_libraries_in_flutter, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SelectComponent extends StatefulWidget {
  final Function? _callback;
  final List<SelectModel> _content;
  final String? _title;

  const SelectComponent(
      {Function? callback, String? title, required List<SelectModel> content})
      : _callback = callback,
        _content = content,
        _title = title;

  @override
  _SelectCustonState createState() => _SelectCustonState();
}

class _SelectCustonState extends State<SelectComponent> {
  int isSelected = 0;

  void _setSelected(item) {
    setState(() {
      widget._callback!(item);
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
        // if (widget._title) TitleComponent(widget._title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in widget._content)
              TextButton(
                child: Text(item.label),
                onPressed: () => _setSelected(item),
                style:
                    _getSelected(item.id) ? uiButton.button1 : uiButton.button1,
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
