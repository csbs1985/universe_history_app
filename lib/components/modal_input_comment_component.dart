// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:uuid/uuid.dart';

class ModalInputCommmentComponent extends StatefulWidget {
  const ModalInputCommmentComponent({Key? key}) : super(key: key);

  @override
  _ModalInputCommmentComponentState createState() =>
      _ModalInputCommmentComponentState();
}

class _ModalInputCommmentComponentState
    extends State<ModalInputCommmentComponent> {
  final TextEditingController _commentController = TextEditingController();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final Api api = Api();
  final Uuid uuid = const Uuid();

  final bool _comments = true;
  late Map<String, dynamic> _comment;

  bool _isInputNotEmpty = false;
  bool _textSigned = true;

  void keyUp(String text) {
    setState(() {
      _isInputNotEmpty = _commentController.text.length > 0 ? true : false;
    });
  }

  dynamic _toggleAnonimous() {
    setState(() {
      _textSigned = !_textSigned;
    });
  }

  void _sendComment() {
    setState(() {
      _comment = {
        'id': uuid.v4(),
        'date': DateTime.now().toString(),
        'historyId': currentHistory.value.first.id,
        'isSigned': _textSigned,
        'isEdit': false,
        'text': _commentController.text.trim(),
        'userId': currentUser.value.first.id,
        'userNickName': currentUser.value.first.nickname,
      };

      api
          .setComment(_comment)
          .then((result) => {
                _upComment(),
              })
          .catchError((error) => print('ERROR: ' + error));
    });
  }

  void _upComment() {
    setState(() {
      currentHistory.value.first.qtyComment++;

      api
          .upNumComment()
          .then((result) => {
                ActivityUtil(ActivitiesEnum.NEW_COMMENT,
                    _commentController.text, currentHistory.value.first.id),
                _setUpQtyCommentUser(),
                _commentController.clear(),
                _isInputNotEmpty = false,
              })
          .catchError((error) => print('ERROR: ' + error));
    });
  }

  void _setUpQtyCommentUser() async {
    currentUser.value.first.qtyComment++;
    await api.setUpQtyCommentUser().then((value) => {
          Navigator.of(context).pop(),
          toast.toast(
              context, ToastEnum.SUCCESS, 'Seu comentário foi publicado.'),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 54.5),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    controller: _commentController,
                    onChanged: (value) => keyUp(value),
                    autofocus: true,
                    maxLines: 100,
                    style: uiTextStyle.text1,
                    decoration: const InputDecoration.collapsed(
                      hintText:
                          "Escreva aqui seu comentário, ele pode ajudar alguém em um momento difícil, escolha com cuidado sua palavras.",
                      hintStyle: uiTextStyle.text7,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Container(
              height: 54.5,
              color: uiColor.comp_1,
              child: Column(
                children: [
                  const DividerComponent(bottom: 0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlutterSwitch(
                          value: _textSigned,
                          activeText: currentUser.value.first.nickname,
                          inactiveText: 'anonimo',
                          activeColor: uiColor.button,
                          inactiveColor: uiColor.buttonSecond,
                          activeToggleColor: uiColor.buttonBorder,
                          inactiveToggleColor: uiColor.buttonSecondBorder,
                          activeTextColor: uiColor.buttonLabel,
                          inactiveTextColor: uiColor.buttonSecondLabel,
                          toggleColor: uiColor.third,
                          width: 90,
                          height: 30,
                          valueFontSize: 12,
                          toggleSize: 20,
                          borderRadius: 10,
                          showOnOff: true,
                          onToggle: (value) => _toggleAnonimous(),
                        ),
                        if (_isInputNotEmpty)
                          Button3dComponent(
                            label: 'Publicar',
                            style: ButtonStyleEnum.PRIMARY,
                            size: ButtonSizeEnum.SMALL,
                            callback: (value) => _sendComment(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
