import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ModalOptionsComponent extends StatefulWidget {
  const ModalOptionsComponent(String type, UserModel user)
      : _type = type,
        _user = user;

  final String _type;
  final UserModel _user;

  @override
  _ModalOptionsComponentState createState() => _ModalOptionsComponentState();
}

class _ModalOptionsComponentState extends State<ModalOptionsComponent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton.icon(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton.icon(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton.icon(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextButton.icon(
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
