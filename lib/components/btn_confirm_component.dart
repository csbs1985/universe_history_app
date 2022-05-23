import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/alert_confirm_component.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnConfirmComponent extends StatefulWidget {
  const BtnConfirmComponent({
    required Function callback,
    required String title,
    required String text,
    String? link,
    String? btnPrimaryLabel,
    String? btnSecondaryLabel,
    String? icon,
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _icon = icon;

  final Function _callback;
  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;
  final String? _icon;

  @override
  _BtnConfirmComponentState createState() => _BtnConfirmComponentState();
}

class _BtnConfirmComponentState extends State<BtnConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Material(
        color: UiColor.comp_1,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: widget._icon != null
              ? TextButton.icon(
                  icon: SvgPicture.asset(widget._icon!),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' ' + widget._title,
                      style: UiTextStyle.text1,
                    ),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () => _showAlertConfirm(),
                )
              : TextButton(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget._title,
                      style: UiTextStyle.text1,
                    ),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () => _showAlertConfirm(),
                ),
        ),
      ),
    );
  }

  Future<Future> _showAlertConfirm() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertConfirmComponent(
          title: widget._title,
          text: widget._text,
          btnPrimaryLabel: widget._btnPrimaryLabel,
          btnSecondaryLabel: widget._btnSecondaryLabel,
          callback: (value) => widget._callback(value),
        );
      },
    );
  }
}
