import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ResumeComponent extends StatelessWidget {
  const ResumeComponent({
    required String resume,
    double? top,
    double? bottom,
    double? width,
  })  : _resume = resume,
        _top = top,
        _bottom = bottom,
        _width = width;

  final String _resume;
  final double? _bottom;
  final double? _top;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      padding: EdgeInsets.fromLTRB(0, _top ?? 0, 0, _bottom ?? 10),
      child: Text(
        _resume,
        style: UiTextStyle.text2,
      ),
    );
  }
}
