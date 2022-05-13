// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class uiTextFormField {
  static InputDecorationTheme primary = InputDecorationTheme(
    hintStyle: uiTextStyle.text1,
    labelStyle: uiTextStyle.text1,
    border: const OutlineInputBorder(),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: uiColor.comp_1,
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(uiBorder.rounded),
        borderSide: const BorderSide(width: 1, color: uiColor.comp_3)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(uiBorder.rounded),
        borderSide: const BorderSide(width: 1, color: uiColor.comp_3)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(uiBorder.rounded),
        borderSide: const BorderSide(width: 1, color: uiColor.comp_3)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(uiBorder.rounded),
        borderSide: const BorderSide(width: 1, color: uiColor.warning)),
  );
}
