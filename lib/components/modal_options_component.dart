// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/pill_component.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

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
  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                PillComponent(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '"' + widget._label + '"',
                    style: uiTextStyle.text1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const DividerComponent(
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 20, 20),
                  child: Column(
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.copy),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Copiar ' + widget._type,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.edit),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Editar ' + widget._type,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.delete),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Excluir ' + widget._type,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _shared(widget._label),
                        icon: SvgPicture.asset(uiSvg.share),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Compartilhar ' + widget._type,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                      const DividerComponent(
                        bottom: 10,
                        top: 10,
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.block),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Bloquear ' + widget._user.nickname,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(uiSvg.delate),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '   Denunciar ' + widget._user.nickname,
                            style: uiTextStyle.text1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
