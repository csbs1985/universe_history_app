// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class PillComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 80,
      height: 4,
      decoration: const BoxDecoration(
          color: uiColor.comp_3,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          )),
    );
  }
}
