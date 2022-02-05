import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universe_history_app/shared/models/category_model.dart';

class MenuNotifier extends StateNotifier<CategoryModel> {
  MenuNotifier() : super(menuItem);

  static CategoryModel menuItem = CategoryModel.allCategories.first;

  void setSelected(CategoryModel item) {
    menuItem = item;
    print(menuItem.id);
  }

  bool getSelected(CategoryModel item) {
    return menuItem.id == item.id ? true : false;
  }
}
