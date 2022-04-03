// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class uiButton {
  static ButtonStyle buttonPrimary = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(16, 8, 16, 8)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );

  static ButtonStyle buttonPrimaryDisabled = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_3),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );

  static ButtonStyle btnFlex = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_3),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );

  static ButtonStyle btnFlexActived = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );

  static ButtonStyle btnLogin = ButtonStyle(
    alignment: Alignment.center,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.second),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );

  static ButtonStyle btnCard = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_3),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );

  static ButtonStyle btnCardActive = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.second),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    ),
  );
  ///////////////////////

  static ButtonStyle selectCard = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(20, 8, 20, 10)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
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
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: uiColor.first),
      ),
    ),
  );
}
