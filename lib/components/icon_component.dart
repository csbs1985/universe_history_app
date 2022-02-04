// ignore_for_file: use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class IconComponent extends StatefulWidget {
  const IconComponent({
    Function? callback,
    Color? color,
    String? route,
    required String icon,
  })  : _callback = callback,
        _color = color,
        _route = route,
        _icon = icon;

  final Function? _callback;
  final Color? _color;
  final String? _route;
  final String _icon;

  @override
  _IconComponentState createState() => _IconComponentState();
}

class _IconComponentState extends State<IconComponent> {
  void _onPressed() {
    setState(() {
      if (widget._route != null) {
        Navigator.of(context).pushNamed("/${widget._route}");
        return;
      }

      widget._callback!(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: SvgPicture.asset(
          widget._icon,
          color: widget._color ?? uiColor.icon,
        ),
        constraints: const BoxConstraints(
          maxWidth: 64,
          minHeight: 32,
        ),
      ),
      onTap: () => _onPressed(),
    );
  }
}
