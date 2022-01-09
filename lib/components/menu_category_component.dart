// // ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/category.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class MenuCategories extends StatefulWidget {
  const MenuCategories({Key? key}) : super(key: key);

  @override
  _MenuCategoriesState createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategories> {
  List<Category> allCategories = Category.allCategories;
  String isSelected = 'todas';

  void _setSelected(String id) {
    setState(() {
      isSelected = id;
    });
  }

  bool _getSelected(String id) {
    return isSelected == id ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allCategories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => TextButton(
        child: Text(
          allCategories[index].label,
          style: _getSelected(allCategories[index].id)
              ? uiTextStyle.text3
              : uiTextStyle.text1,
        ),
        onPressed: () {
          _setSelected(allCategories[index].id);
        },
      ),
    );
  }
}
