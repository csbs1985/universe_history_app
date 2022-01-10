// ignore_for_file: use_key_in_widget_constructors, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/category.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class RadioCuston extends StatefulWidget {
  const RadioCuston(
    this.title,
    this.content,
  );

  final String title;
  final List<Category> content;

  @override
  _RadioCustonState createState() => _RadioCustonState();
}

class _RadioCustonState extends State<RadioCuston> {
  List<String> listSelect = [];

  bool _filterList(String id) {
    return id == 'todas' || id == 'favoritas' || id == 'minhas' ? false : true;
  }

  void _setSelected(String id) {
    setState(() {
      listSelect.contains(id) ? listSelect.remove(id) : listSelect.add(id);
    });
  }

  bool _getSelected(String id) {
    return listSelect.contains(id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: uiTextStyle.header2,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: [
            for (var item in widget.content)
              if (_filterList(item.id))
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => _setSelected(item.id),
                    child: Text(
                      item.label,
                      style: _getSelected(item.id)
                          ? uiTextStyle.active
                          : uiTextStyle.chips,
                    ),
                    style: _getSelected(item.id)
                        ? ButtonsTheme.active
                        : ButtonsTheme.chips,
                  ),
                ),
          ],
        )
      ],
    );
  }
}
