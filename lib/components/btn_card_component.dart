// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_final_fields, unused_local_variable, prefer_typing_uninitialized_variables, unnecessary_null_in_if_null_operators, must_call_super

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnCardComponent extends StatefulWidget {
  const BtnCardComponent({Function? callback, required content})
      : _content = content,
        _callback = callback;

  final _content;
  final Function? _callback;

  @override
  _BtnCardComponentState createState() => _BtnCardComponentState();
}

class _BtnCardComponentState extends State<BtnCardComponent> {
  String? _itemSelected;

  void _onPressed(item) {
    setState(() {
      _itemSelected = item.id;
      widget._callback!(item);
    });
  }

  bool _getSelected(String _id) {
    return _itemSelected == _id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var item in widget._content)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 4),
            child: TextButton(
              onPressed: () => _onPressed(item),
              style: _getSelected(item.id)
                  ? uiButton.buttonCardActive
                  : uiButton.buttonCard,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: _getSelected(item.id)
                            ? uiTextStyle.text5
                            : uiTextStyle.text1),
                    if (item.text.length > 0)
                      Text(item.text,
                          style: _getSelected(item.id)
                              ? uiTextStyle.text11
                              : uiTextStyle.text2),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
