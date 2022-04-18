// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 38,
            child: ListView.builder(
              itemCount: CategoryModel.allCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return canShow(widget.allCategories[index].label)
                    ? TextButton(
                        style: _getSelected(widget.allCategories[index])
                            ? uiButton.buttonMenuActive
                            : uiButton.buttonMenu,
                        child: Text(
                          widget.allCategories[index].label!,
                          style: _getSelected(widget.allCategories[index])
                              ? uiTextStyle.buttonPrimary
                              : uiTextStyle.text7,
                        ),
                        onPressed: () => _setSelected(
                          widget.allCategories[index],
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ),
        );
      },
    );
  }
}
