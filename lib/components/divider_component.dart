import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class DividerComponent extends StatelessWidget {
  const DividerComponent({
    double? left,
    double? top,
    double? right,
    double? bottom,
  })  : _left = left,
        _top = top,
        _right = right,
        _bottom = bottom;

  final double? _left;
  final double? _top;
  final double? _right;
  final double? _bottom;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Column(
        children: [
          SizedBox(height: _top ?? 0),
          Divider(
              height: 0.5,
              thickness: 0.5,
              indent: _left ?? 0,
              endIndent: _right ?? 0,
              color: uiColor.comp_3),
          SizedBox(height: _bottom ?? 20)
        ],
      ),
    );
  }
}
