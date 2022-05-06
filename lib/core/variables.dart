import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/category_model.dart';

ValueNotifier<CategoryModel> menuItemSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

ValueNotifier<List<String>> currentBookmarks = ValueNotifier(<String>[]);

ValueNotifier<String> currentToken = ValueNotifier<String>('');

ValueNotifier<bool> currentNotification = ValueNotifier<bool>(false);

ValueNotifier<String> currentDialog = ValueNotifier<String>('');
