// ignore_for_file: use_key_in_widget_constructors

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: widget._svg == null
            ? const EdgeInsets.all(0)
            : const EdgeInsets.fromLTRB(16, 8, 16, 8),
        height: widget._svg != null ? 32 : widget._size,
        child: SvgPicture.asset(
          widget._svg ?? uiSvg.logo,
          color: widget._color ?? uiColor.icon,
        ),
        constraints: BoxConstraints(
          maxWidth: widget._size ?? 80,
          maxHeight: 32,
        ),
      ),
      onTap: () => _onPressed(),
    );
  }
}

// TODO: adicionar IconComponent no modal de comentários