// ignore_for_file: use_key_in_widget_constructors, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SelectCategoriesComponent extends StatefulWidget {
  final Function? _callback;
  final List<CategoryModel> _content;
  final String _title;
  final String _resume;

  const SelectCategoriesComponent({
    required Function? callback,
    required List<CategoryModel> content,
    required String title,
    required String resume,
  })  : _callback = callback,
        _content = content,
        _resume = resume,
        _title = title;

  @override
  _SelectCategoriesComponentState createState() =>
      _SelectCategoriesComponentState();
}

class _SelectCategoriesComponentState extends State<SelectCategoriesComponent> {
  List<String> listSelect = [];

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
        TitleResumeComponent(widget._title, widget._resume),
        Wrap(
          children: [
            for (var item in widget._content)
              if (item.isShowInput! && !item.isDisabled!)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => _setSelected(item.id!),
                    child: Text(
                      item.label!,
                      style: _getSelected(item.id!)
                          ? uiTextStyle.btnFlexActived
                          : uiTextStyle.btnFlex,
                    ),
                    style: _getSelected(item.id!)
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
