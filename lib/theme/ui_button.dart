// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class uiButton {
  static ButtonStyle btnCard = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.comp_1),
      ),
    ),
  );

  static ButtonStyle button1 = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
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
        borderRadius: BorderRadius.circular(50),
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
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );

  static ButtonStyle selectCard = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.comp_1),
      ),
    ),
  );

  static ButtonStyle selectCardActived = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    foregroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );
}
