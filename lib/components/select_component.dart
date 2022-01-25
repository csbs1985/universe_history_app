// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_import, unused_field, avoid_web_libraries_in_flutter, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/subtitle_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/shared/models/select_modal.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SelectComponent extends StatefulWidget {
  final Function? _callback;
  final List<SelectModel> _content;
  final String? _title;
  final String? _type;

  const SelectComponent({
    Function? callback,
    String? title,
    required String type,
    required List<SelectModel> content,
  })  : _callback = callback,
        _content = content,
        _title = title,
        _type = type;

  @override
  _SelectCustonState createState() => _SelectCustonState();
}

class _SelectCustonState extends State<SelectComponent> {
  int isSelected = 0;

  void _setSelected(id) {
    setState(() {
      isSelected = id;
      if (widget._callback != null) {
        widget._callback!({widget._type, id});
      }
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
        SubTitleComponent(widget._title!),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var item in widget._content)
              TextButton(
                child: Text(
                  item.label,
                  style: _getSelected(item.id)
                      ? uiTextStyle.btnFlexActived
                      : uiTextStyle.btnFlex,
                ),
                onPressed: () => _setSelected(item.id),
                style: _getSelected(item.id)
                    ? uiButton.btnFlexActived
                    : uiButton.btnFlex,
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
