import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_colors.dart';

class ButtonsTheme {
  static ButtonStyle button1 = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );

  static ButtonStyle chips = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.second),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.second),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );

  static ButtonStyle active = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );
}
