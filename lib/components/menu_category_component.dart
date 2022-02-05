// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universe_history_app/notifiers/menu_notifier.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

final menuProvider = StateNotifierProvider<MenuNotifier, CategoryModel>((ref) {
  return MenuNotifier();
});

class MenuCategoryComponent extends ConsumerWidget {
  List<CategoryModel> allCategories = CategoryModel.allCategories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: uiColor.second,
      child: ListView.builder(
          itemCount: allCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Consumer(builder: (context, ref, _) {
              final _menuItem = ref.watch(menuProvider.notifier);
              return Container(
                color: ref
                        .read(menuProvider.notifier)
                        .getSelected(allCategories[index])
                    ? uiColor.comp_1
                    : uiColor.second,
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
                    child: Text(allCategories[index].label!,
                        style: uiTextStyle.text1),
                  ),
                  onPressed: () {
                    ref
                        .read(menuProvider.notifier)
                        .setSelected(allCategories[index]);
                  },
                ),
              );
            });
          }),
    );
  }
}
