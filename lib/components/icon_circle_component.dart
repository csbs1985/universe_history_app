// ignore_for_file: use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconCicleComponent extends StatefulWidget {
  const IconCicleComponent({
    required Color color,
    required String icon,
  })  : _color = color,
        _icon = icon;

  final Color? _color;
  final String _icon;

  @override
  _IconCicleComponentState createState() => _IconCicleComponentState();
}

class _IconCicleComponentState extends State<IconCicleComponent> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 32,
        height: 32,
        color: widget._color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(widget._icon),
        ),
      ),
    );
  }
}
