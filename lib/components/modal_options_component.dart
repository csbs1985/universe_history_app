// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/button_option_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class ModalOptionsComponent extends StatefulWidget {
  const ModalOptionsComponent(
    String id,
    String type,
    String idUser,
    String userNickName,
    String text,
  )   : _id = id,
        _type = type,
        _idUser = idUser,
        _userNickName = userNickName,
        _text = text;

  final String _id;
  final String _type;
  final String _idUser;
  final String _userNickName;
  final String _text;

  @override
  _ModalOptionsComponentState createState() => _ModalOptionsComponentState();
}

class _ModalOptionsComponentState extends State<ModalOptionsComponent> {
  final ToastComponent toast = ToastComponent();

  bool _canEdit() {
    return currentUser.value.first.id == widget._idUser ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                children: [
                  ButtonOptionComponent(
                    label: 'Copiar ' + widget._type,
                    icon: uiSvg.copy,
                    callback: (value) {
                      Clipboard.setData(ClipboardData(text: widget._text));
                      toast.toast(context, ToastEnum.SUCCESS, 'Texto copiado!');
                      Navigator.of(context).pop();
                    },
                  ),
                  if (_canEdit())
                    ButtonOptionComponent(
                      callback: () {},
                      label: 'Editar ' + widget._type,
                      icon: uiSvg.edit,
                    ),
                  ButtonOptionComponent(
                    callback: () {},
                    label: 'Excluir ' + widget._type,
                    icon: uiSvg.delete,
                  ),
                  ButtonOptionComponent(
                    callback: () {},
                    label: 'Bloquear ' + widget._userNickName,
                    icon: uiSvg.block,
                  ),
                  ButtonOptionComponent(
                    callback: () {},
                    label: 'Denunciar ' + widget._userNickName,
                    icon: uiSvg.delate,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
