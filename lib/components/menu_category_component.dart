// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class MenuCategoryComponent extends StatefulWidget {
  const MenuCategoryComponent({Key? key}) : super(key: key);

  @override
  _MenuCategoriesState createState() => _MenuCategoriesState();
}

class _MenuCategoriesState extends State<MenuCategoryComponent> {
  List<CategoryModel> allCategories = CategoryModel.allCategories;
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
    return Container(
      color: Color(0xFF161d27),
      child: ListView.builder(
        itemCount: allCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            height: double.infinity,
            color: _getSelected(allCategories[index].id)
                ? Color(0xFF1f2938)
                : Color(0xFF161d27),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                allCategories[index].label,
                style: uiTextStyle.text1,
              ),
            ),
          ),
          onPressed: () {
            _setSelected(allCategories[index].id);
          },
        ),
      ),
    );
  }
}
