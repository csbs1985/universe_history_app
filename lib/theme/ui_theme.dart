// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_form_field.dart';

class uiTheme {
  static ThemeData theme1 = ThemeData(
    scaffoldBackgroundColor: uiColor.comp_1,
    fontFamily: 'nunito-regular',
    appBarTheme:
        const AppBarTheme(backgroundColor: uiColor.comp_1, elevation: 0),
    inputDecorationTheme: uiTextFormField.primary,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: uiColor.first),
  );
}
