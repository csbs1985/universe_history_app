// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/models/category_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class MenuComponent extends StatefulWidget {
  List<CategoryModel> allCategories = CategoryModel.allCategories;

  @override
  _MenuComponentState createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> {
  bool canShow(String? item) {
    return (item == 'minhas' || item == 'salvas') && currentUser.value.isEmpty
        ? false
        : true;
  }

  void _setSelected(CategoryModel item) {
    setState(() {
      menuItemSelected.value = item;
    });
  }

  bool _getSelected(CategoryModel item) {
    return menuItemSelected.value.id == item.id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentUser,
      builder: (context, value, __) {
        return SizedBox(
          height: 36,
          child: ListView.builder(
            itemCount: CategoryModel.allCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return canShow(widget.allCategories[index].label)
                  ? Row(
                      children: [
                        if (widget.allCategories[index].id == 'todas')
                          const SizedBox(width: 16),
                        TextButton(
                          style: _getSelected(widget.allCategories[index])
                              ? uiButton.buttonMenuActive
                              : uiButton.buttonMenu,
                          child: Text(
                            widget.allCategories[index].label!.toLowerCase(),
                            style: _getSelected(widget.allCategories[index])
                                ? uiTextStyle.menuActive
                                : uiTextStyle.menu,
                          ),
                          onPressed: () =>
                              _setSelected(widget.allCategories[index]),
                        ),
                        if (widget.allCategories[index].id == 'violencia')
                          const SizedBox(width: 16),
                      ],
                    )
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }
}
