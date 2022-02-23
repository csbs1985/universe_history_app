// ignore_for_file: use_key_in_widget_constructors, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_primary_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class AlertConfirmComponent extends StatefulWidget {
  const AlertConfirmComponent({
    required Function callback,
    String? title,
    String? text,
    String? link,
    String btnPrimaryLabel = 'Ok',
    String btnSecondaryLabel = 'Cancelar',
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _link = link;

  final Function _callback;
  final String? _title;
  final String? _text;
  final String _btnPrimaryLabel;
  final String _btnSecondaryLabel;
  final String? _link;

  @override
  State<AlertConfirmComponent> createState() => _AlertConfirmComponentState();
}

class _AlertConfirmComponentState extends State<AlertConfirmComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<Future> _showAlertConfirm(
    String title,
    String text,
    String link,
    String _btnPrimaryLabel,
    String _btnSecondaryLabel,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: uiColor.comp_1,
          title: Text(
            title,
            style: uiTextStyle.text5,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  text,
                  style: uiTextStyle.text1,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => widget._callback(true),
                    child: Text(
                      _btnSecondaryLabel,
                      style: uiTextStyle.text3,
                    ),
                  ),
                  BtnPrimaryComponent(
                    label: _btnPrimaryLabel,
                    callback: (value) => widget._callback(false),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
