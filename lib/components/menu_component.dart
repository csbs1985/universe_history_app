// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class MenuComponent extends StatefulWidget {
  List<CategoryModel> allCategories = CategoryModel.allCategories;

  @override
  _MenuComponentState createState() => _MenuComponentState();
}

class _MenuComponentState extends State<MenuComponent> {
  bool canShow(String? item) {
    return item == 'minhas' && currentUser.value.isEmpty ? false : true;
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
        return Container(
          height: 38,
          color: uiColor.comp_1,
          child: ListView.builder(
            itemCount: CategoryModel.allCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return canShow(widget.allCategories[index].label)
                  ? Container(
                      color: uiColor.comp_1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            widget.allCategories[index].label!,
                            style: _getSelected(widget.allCategories[index])
                                ? uiTextStyle.text5
                                : uiTextStyle.text7,
                          ),
                        ),
                        onPressed: () => _setSelected(
                          widget.allCategories[index],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        );
      },
    );
  }
}
