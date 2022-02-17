import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/shared/models/category_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';

ValueNotifier<CategoryModel> menuItemSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

ValueNotifier<Object?> currentUser =
    ValueNotifier<Object?>(UserModel.user.first);

ValueNotifier<String> currentHistory = ValueNotifier('');

ValueNotifier<num> currentQtyComment = ValueNotifier(0);

ValueNotifier<List<String>> currentBookmarks = ValueNotifier(<String>[]);
