// ignore_for_file: no_logic_in_create_state, use_key_in_widget_constructors, unused_element, prefer_const_constructors

import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnConfirmComponent extends StatefulWidget {
  const BtnConfirmComponent({
    required Function callback,
    required String title,
    required String text,
    required String link,
    String? btnPrimaryLabel,
    String? btnSecondaryLabel,
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _link = link;

  final Function _callback;
  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;
  final String _link;

  @override
  _BtnConfirmComponentState createState() => _BtnConfirmComponentState();
}

class _BtnConfirmComponentState extends State<BtnConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 10),
      child: Material(
        color: uiColor.comp_1,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget._title,
                style: uiTextStyle.text1,
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
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          actionsPadding: const EdgeInsets.fromLTRB(10, 20, 10, 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor: uiColor.comp_1,
          title: Text(
            widget._title,
            style: uiTextStyle.header2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  widget._text,
                  style: uiTextStyle.text1,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button3dComponent(
                  label: 'Sair',
                  size: ButtonSizeEnum.MEDIUM,
                  style: ButtonStyleEnum.SECOND,
                  callback: (value) => widget._callback(true),
                ),
                Button3dComponent(
                  label: 'Cancelar',
                  size: ButtonSizeEnum.MEDIUM,
                  style: ButtonStyleEnum.PRIMARY,
                  callback: (value) => widget._callback(false),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
