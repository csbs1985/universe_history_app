import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/shared/models/category_model.dart';

ValueNotifier<CategoryModel> menuItemSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

ValueNotifier<List<String>> currentBookmarks = ValueNotifier(<String>[]);

ValueNotifier<String> currentToken = ValueNotifier<String>('');
