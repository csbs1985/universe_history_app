// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconComponent extends StatefulWidget {
  const IconComponent({
    required String svg,
    Function? callback,
    String? route,
    String? action,
    double? size,
  })  : _action = action,
        _callback = callback,
        _svg = svg,
        _route = route,
        _size = size;

  final Function? _callback;
  final String _svg;
  final String? _route;
  final String? _action;
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
    return IconButton(
      icon: SvgPicture.asset(widget._svg),
      iconSize: widget._size ?? 14,
      onPressed: () => _onPressed(),
    );
  }
}


// TODO: adicionar IconComponent no modal de comentários