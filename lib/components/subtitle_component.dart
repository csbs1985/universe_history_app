// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class SubTitleComponent extends StatelessWidget {
  const SubTitleComponent(this.subtitle);

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        subtitle,
        style: uiTextStyle.header2,
      ),
    );
  }
}
