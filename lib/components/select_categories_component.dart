// ignore_for_file: use_key_in_widget_constructors, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/subtitle_resume_component.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';

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
      if (widget._callback != null) widget._callback!(listSelect);
    });
  }

  bool _getSelected(String id) {
    return listSelect.contains(id) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SubtitleResumeComponent(title: widget._title, resume: widget._resume),
          const SizedBox(height: 10),
          Wrap(
            children: [
              for (var item in widget._content)
                if (item.isShowInput! && !item.isDisabled!)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: SizedBox(
                      height: 38,
                      child: TextButton(
                        onPressed: () => _setSelected(item.id!),
                        child: Text(
                          item.label!.toLowerCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _getSelected(item.id!)
                                ? uiColor.buttonLabel
                                : uiColor.buttonSecondLabel,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: _getSelected(item.id!)
                              ? MaterialStateProperty.all(uiColor.button)
                              : MaterialStateProperty.all(uiColor.buttonSecond),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
