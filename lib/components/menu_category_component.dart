// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print, prefer_const_constructors_in_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universe_history_app/providers/menu_provider.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

// final menuProvider = StateProvider((ref) => MenuProvider(ref));

class MenuCategoryComponent extends StatelessWidget {
  MenuCategoryComponent({Function? callback}) : _callback = callback;
  final Function? _callback;

  @override
  Widget build(BuildContext context) {
    return MenuCategoryView();
  }
}

class MenuCategoryView extends ConsumerWidget {
  List<CategoryModel> allCategories = CategoryModel.allCategories;
  String isSelected = 'todas';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(menuProvider);
    return Consumer(builder: (context, ref, _) {
      return Container(
        color: uiColor.second,
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
              color: ref
                      .read(menuProvider.notifier)
                      .getSelected(allCategories[index].id)
                  ? uiColor.comp_1
                  : uiColor.second,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Text(allCategories[index].label, style: uiTextStyle.text1),
              ),
            ),
            onPressed: () {
              ref
                  .read(menuProvider.notifier)
                  .setSelected(allCategories[index].id);
            },
          ),
        ),
      );
    });
  }
}
