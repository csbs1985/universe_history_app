// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class uiButton {
  static ButtonStyle buttonPrimary = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.fromLTRB(16, 8, 16, 8)),
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiBorder.rounded),
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
        borderRadius: BorderRadius.circular(uiBorder.rounded),
      ),
    ),
  );

  static ButtonStyle btnFlex = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_3),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiBorder.none),
      ),
    ),
  );

  static ButtonStyle btnFlexActived = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uiBorder.none),
      ),
    ),
  );

  static ButtonStyle buttonCard = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_3),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uiBorder.rounded)),
    ),
  );

  static ButtonStyle buttonCardActive = ButtonStyle(
    alignment: Alignment.bottomLeft,
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uiBorder.rounded)),
    ),
  );

  static ButtonStyle buttonMenu = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.comp_1),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 10)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uiBorder.rounded)),
    ),
  );

  static ButtonStyle buttonMenuActive = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 10)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uiBorder.rounded)),
    ),
  );
}
