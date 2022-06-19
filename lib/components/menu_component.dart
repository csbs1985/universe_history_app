// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
    return (item == CategoriesEnum.MY.name ||
                item == CategoriesEnum.SAVE.name) &&
            currentUser.value.isEmpty
        ? false
        : true;
  }

  void _setSelected(CategoryModel item) {
    setState(() {
      currentMenuSelected.value = item;
    });
  }

  bool _getSelected(CategoryModel item) {
    return currentMenuSelected.value.id == item.id ? true : false;
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return canShow(widget.allCategories[index].label)
                  ? Row(
                      children: [
                        TextButton(
                          style: _getSelected(widget.allCategories[index])
                              ? UiButton.buttonMenuActive
                              : UiButton.buttonMenu,
                          child: Text(
                            widget.allCategories[index].label!.toLowerCase(),
                            style: _getSelected(widget.allCategories[index])
                                ? UiTextStyle.menuActive
                                : UiTextStyle.menu,
                          ),
                          onPressed: () =>
                              _setSelected(widget.allCategories[index]),
                        ),
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
