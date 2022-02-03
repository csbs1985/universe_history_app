// ignore_for_file: unused_element, unnecessary_this

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universe_history_app/providers/menu_state.dart';
import 'package:universe_history_app/shared/models/category_model.dart';

final menuProvider =
    StateNotifierProvider<MenuProvider, MenuState>((ref) => MenuProvider(ref));

class MenuProvider extends StateNotifier<MenuState> {
  MenuProvider(this.ref) : super(MenuInitial());

  final Ref ref;

  List<CategoryModel> allCategories = CategoryModel.allCategories;
  String isSelected = 'todas';

  void setSelected(String id) {
    isSelected = id;
    // _callback!(isSelected);
  }

  bool getSelected(String id) {
    return isSelected == id ? true : false;
  }
}
