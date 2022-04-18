// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:universe_history_app/components/button_option_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';

class ModalOptionsComponent extends StatefulWidget {
  const ModalOptionsComponent(String label, String type, UserModel user)
      : _label = label,
        _type = type,
        _user = user;

  final String _label;
  final String _type;
  final UserModel _user;

  @override
  _ModalOptionsComponentState createState() => _ModalOptionsComponentState();
}

Future<void> _shared(String text) async {
  FlutterShare.shareFile(
    title:
        'Olá, estou usando o app History, quero compartilhar este conteúdo com você: ',
    text: '"' + text + '"',
    chooserTitle: 'Escolha como pretende compartilhar',
    filePath: '',
  );
}

class _ModalOptionsComponentState extends State<ModalOptionsComponent> {
  final ToastComponent toast = ToastComponent();

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
                      Clipboard.setData(ClipboardData(text: widget._label));
                      toast.toast(context, ToastEnum.SUCCESS, 'Texto copiado!');
                      Navigator.of(context).pop();
                    },
                  ),
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
                    label: 'Bloquear ' + widget._user.nickname,
                    icon: uiSvg.block,
                  ),
                  ButtonOptionComponent(
                    callback: () {},
                    label: 'Denunciar ' + widget._user.nickname,
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
