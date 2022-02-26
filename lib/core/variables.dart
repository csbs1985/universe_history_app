import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/shared/models/category_model.dart';

ValueNotifier<CategoryModel> menuItemSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

ValueNotifier<num> currentQtyComment = ValueNotifier(0);

ValueNotifier<List<String>> currentBookmarks = ValueNotifier(<String>[]);
