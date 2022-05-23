import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class LogoComponent extends StatefulWidget {
  const LogoComponent({
    Function? callback,
    Color? color,
    String? route,
    String? icon,
    double? size,
  })  : _callback = callback,
        _color = color,
        _route = route,
        _size = size,
        _icon = icon;

  final Function? _callback;
  final Color? _color;
  final String? _route;
  final String? _icon;
  final double? _size;

  @override
  _LogoComponentState createState() => _LogoComponentState();
}

class _LogoComponentState extends State<LogoComponent> {
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
    if (widget._icon == uiSvg.logo) {
      return null;
    } else if (widget._color != null) {
      return widget._color;
    }
    return uiColor.icon;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: SvgPicture.asset(
          widget._icon ?? uiSvg.name,
          color: _setColor(),
        ),
        constraints: BoxConstraints(
          maxHeight: widget._size ?? 32,
        ),
      ),
      onTap: () => _onPressed(),
    );
  }
}
