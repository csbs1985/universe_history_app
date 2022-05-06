// ignore_for_file: use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_border.dart';

class IconCicleComponent extends StatefulWidget {
  const IconCicleComponent({
    Color? color,
    required String icon,
    double? size,
    double? margin,
  })  : _color = color,
        _icon = icon,
        _size = size,
        _margin = margin;

  final Color? _color;
  final String _icon;
  final double? _size;
  final double? _margin;

  @override
  _IconCicleComponentState createState() => _IconCicleComponentState();
}

class _IconCicleComponentState extends State<IconCicleComponent> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(uiBorder.circle),
      child: Container(
        width: widget._size ?? 32,
        height: widget._size ?? 32,
        color: widget._color,
        child: Padding(
            padding: EdgeInsets.all(widget._margin ?? 8),
            child: SvgPicture.asset(widget._icon)),
      ),
    );
  }
}
