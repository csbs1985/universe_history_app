import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class UiTextFormField {
  static InputDecorationTheme primary = InputDecorationTheme(
    hintStyle: UiTextStyle.text1,
    labelStyle: UiTextStyle.text1,
    border: const OutlineInputBorder(),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: UiColor.comp_1,
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.comp_3),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.comp_3),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.comp_3),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      borderSide: const BorderSide(width: 1, color: UiColor.warning),
    ),
  );
}
