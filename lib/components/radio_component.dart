// ignore_for_file: use_key_in_widget_constructors, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/subtitle_component.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class RadioComponent extends StatefulWidget {
  final Function? _callback;
  final List<CategoryModel> _content;
  final String _title;

  const RadioComponent({
    Function? callback,
    required String title,
    required List<CategoryModel> content,
  })  : _callback = callback,
        _content = content,
        _title = title;

  @override
  _RadioCustonState createState() => _RadioCustonState();
}

class _RadioCustonState extends State<RadioComponent> {
  List<String> listSelect = [];

  bool _filterList(String id) {
    return id == 'todas' || id == 'favoritas' || id == 'minhas' ? false : true;
  }

  void _setSelected(String id) {
    setState(() {
      listSelect.contains(id) ? listSelect.remove(id) : listSelect.add(id);
      if (widget._callback != null) {
        widget._callback!(listSelect);
      }
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
        SubTitleComponent(widget._title),
        Wrap(
          children: [
            for (var item in widget._content)
              if (_filterList(item.id))
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => _setSelected(item.id),
                    child: Text(
                      item.label,
                      style: _getSelected(item.id)
                          ? uiTextStyle.btnFlexActived
                          : uiTextStyle.btnFlex,
                    ),
                    style: _getSelected(item.id)
                        ? uiButton.btnTagActived
                        : uiButton.btnTag,
                  ),
                ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
