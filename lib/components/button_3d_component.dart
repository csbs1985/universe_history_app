import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class Button3dComponent extends StatefulWidget {
  const Button3dComponent({
    required Function callback,
    required String label,
    required ButtonStyleEnum style,
    required ButtonSizeEnum size,
  })  : _callback = callback,
        _label = label,
        _style = style,
        _size = size;

  final Function _callback;
  final String _label;
  final ButtonStyleEnum _style;
  final ButtonSizeEnum _size;

  @override
  State<Button3dComponent> createState() => _Button3dComponentState();
}

class _Button3dComponentState extends State<Button3dComponent> {
  Color _backColor = uiColor.first;
  Color _borderColor = uiColor.second;
  TextStyle _styleText = uiTextStyle.buttonLabel;

  final double _borderSize = 4;

  late double _position = _borderSize;
  late double _width;
  late double _height;

  @override
  initState() {
    _getStyle();
    super.initState();
  }

  _getStyle() {
    if (widget._style == ButtonStyleEnum.PRIMARY) {
      _backColor = uiColor.button;
      _borderColor = uiColor.buttonBorder;
      _styleText = uiTextStyle.buttonLabel;
    }
    if (widget._style == ButtonStyleEnum.SECOND) {
      _backColor = uiColor.buttonSecond;
      _borderColor = uiColor.buttonSecondBorder;
      _styleText = uiTextStyle.buttonSecondLabel;
    }
    if (widget._style == ButtonStyleEnum.DISABLED) {
      _backColor = uiColor.buttonDisabled;
      _borderColor = uiColor.buttonDisabledBorder;
      _styleText = uiTextStyle.buttonLabel;
    }
  }

  double _getWidth() {
    if (widget._size == ButtonSizeEnum.SMALL) return 90;
    if (widget._size == ButtonSizeEnum.MEDIUM) return 100;
    if (widget._size == ButtonSizeEnum.LARGE) {
      return MediaQuery.of(context).size.width - uiSize.widthFullLessPadding;
    }
    return _width;
  }

  double _getHeight() {
    if (widget._size == ButtonSizeEnum.SMALL) return 32 - _borderSize;
    if (widget._size == ButtonSizeEnum.MEDIUM) return 42 - _borderSize;
    if (widget._size == ButtonSizeEnum.LARGE) return 48 - _borderSize;
    return _height - _borderSize;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: _getWidth(),
        height: _getHeight() + _borderSize,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Container(
                    width: _getWidth(),
                    height: _getHeight(),
                    decoration: BoxDecoration(
                        color: _borderColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))))),
            AnimatedPositioned(
              curve: Curves.easeIn,
              bottom: _position,
              duration: const Duration(milliseconds: 10),
              child: Container(
                  width: _getWidth(),
                  height: _getHeight(),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: _backColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Center(child: Text(widget._label, style: _styleText))),
            ),
          ],
        ),
      ),
      onTapUp: (_) {
        if (widget._style != ButtonStyleEnum.DISABLED) {
          setState(() {
            _position = _borderSize;
            widget._callback(true);
          });
        }
      },
      onTapDown: (_) {
        if (widget._style != ButtonStyleEnum.DISABLED) {
          setState(() {
            _position = 0;
          });
        }
      },
      onTapCancel: () {
        if (widget._style != ButtonStyleEnum.DISABLED) {
          setState(() {
            _position = _borderSize;
          });
        }
      },
    );
  }
}

enum ButtonStyleEnum { DISABLED, SECOND, PRIMARY }
enum ButtonSizeEnum { LARGE, SMALL, MEDIUM }
