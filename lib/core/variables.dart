import 'package:flutter/material.dart';
import 'package:universe_history_app/models/category_model.dart';

ValueNotifier<CategoryModel> currentMenuSelected =
    ValueNotifier<CategoryModel>(CategoryModel.allCategories.first);

ValueNotifier<String> currentToken = ValueNotifier<String>('');

ValueNotifier<bool> currentNotification = ValueNotifier<bool>(false);

ValueNotifier<String> currentDialog = ValueNotifier<String>('');

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
