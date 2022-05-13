// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class TitleComponent extends StatelessWidget {
  const TitleComponent({required String title, double? top, double? bottom})
      : _title = title,
        _top = top,
        _bottom = bottom;

  final String _title;
  final double? _bottom;
  final double? _top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, _top ?? 0, 0, _bottom ?? 10),
      child: Text(_title, style: uiTextStyle.title1),
    );
  }
}
