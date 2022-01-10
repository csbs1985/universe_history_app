// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class uiTheme {
  static ThemeData theme1 = ThemeData(
    scaffoldBackgroundColor: uiColor.second,
    fontFamily: 'segoe',
    appBarTheme: const AppBarTheme(
      backgroundColor: uiColor.second,
      elevation: 0,
    ),
  );
}
