// ignore_for_file: use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class IconComponent extends StatefulWidget {
  const IconComponent({
    Function? callback,
    Color? color,
    String? action,
    String? route,
    String? svg,
    double? size,
  })  : _action = action,
        _callback = callback,
        _color = color,
        _route = route,
        _size = size,
        _svg = svg;

  final Function? _callback;
  final Color? _color;
  final String? _action;
  final String? _route;
  final String? _svg;
  final double? _size;

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

  Color? _setColor() {
    if (widget._svg == uiSvg.logo) {
      return null;
    } else if (widget._color != null) {
      return widget._color;
    }
    return uiColor.icon;
  }

  double _setMaxHeight() {
    if (widget._svg == uiSvg.logo) {
      return double.infinity;
    } else if (widget._svg == uiSvg.name) {
      return 48;
    }
    return 32;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        padding: widget._svg == null
            ? const EdgeInsets.all(0)
            : const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: SvgPicture.asset(
          widget._svg ?? uiSvg.name,
          color: _setColor(),
        ),
        constraints: BoxConstraints(
          maxWidth: widget._size ?? 54,
          maxHeight: _setMaxHeight(),
        ),
      ),
      onTap: () => _onPressed(),
    );
  }
}
