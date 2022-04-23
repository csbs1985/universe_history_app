// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new, use_key_in_widget_constructors

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
  const ModalInputCommmentComponent({String? id}) : _id = id;

  final String? _id;

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

  late Map<String, dynamic> _comment;
  Map<String, dynamic>? _commentEdit;
  bool isEdit = false;

  bool _isInputNotEmpty = false;
  bool _textSigned = true;

  @override
  void initState() {
    if (widget._id != null) {
      isEdit = true;
      api
          .getComment(widget._id!)
          .then((result) => {
                _commentController.text = result.docs[0].data()['text'],
                _isInputNotEmpty = true,
                _textSigned = result.docs[0].data()['isSigned'],
                _commentEdit = result.docs[0].data(),
                _commentEdit?['edit'] = true,
              })
          .catchError((error) => print('ERROR:' + error.toString()));
    }

    super.initState();
  }

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
        'id': _commentEdit?['id'] ?? uuid.v4(),
        'date': _commentEdit?['date'] ?? DateTime.now().toString(),
        'historyId':
            _commentEdit?['historyId'] ?? currentHistory.value.first.id,
        'isSigned': _textSigned,
        'isEdit': _commentEdit?['edit'] ?? false,
        'isDelete': false,
        'text': _commentController.text.trim(),
        'userId': _commentEdit?['userId'] ?? currentUser.value.first.id,
        'userNickName':
            _commentEdit?['userNickName'] ?? currentUser.value.first.nickname,
      };

      api
          .setComment(_comment)
          .then((result) => _upComment())
          .catchError((error) => print('ERROR: ' + error));
    });
  }

  void _upComment() {
    setState(
      () async {
        if (!isEdit) {
          currentHistory.value.first.qtyComment++;
        }

        await api
            .upNumComment()
            .then((result) => {
                  ActivityUtil(ActivitiesEnum.NEW_COMMENT,
                      _commentController.text, currentHistory.value.first.id),
                  _setUpQtyCommentUser(),
                  _commentController.clear(),
                  _isInputNotEmpty = false,
                })
            .catchError((error) => print('ERROR: ' + error));
      },
    );
  }

  void _setUpQtyCommentUser() {
    if (!isEdit) {
      currentUser.value.first.qtyComment++;
    }

    api
        .setUpQtyCommentUser()
        .then(
          (value) => {
            toast.toast(
              context,
              ToastEnum.SUCCESS,
              isEdit
                  ? 'Seu comentário foi alterado.'
                  : 'Seu comentário foi publicado.',
            ),
            Navigator.of(context).pop(),
          },
        )
        .catchError((error) => print('ERROR: ' + error));
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
                        Row(
                          children: [
                            FlutterSwitch(
                              width: 48,
                              height: 32,
                              value: _textSigned,
                              activeColor: uiColor.button,
                              inactiveColor: uiColor.buttonSecond,
                              activeToggleColor: uiColor.buttonBorder,
                              inactiveToggleColor: uiColor.buttonSecondBorder,
                              activeTextColor: uiColor.buttonLabel,
                              inactiveTextColor: uiColor.buttonSecondLabel,
                              toggleSize: 20,
                              onToggle: (value) => _toggleAnonimous(),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _textSigned
                                  ? currentUser.value.first.nickname
                                  : 'anônimo',
                              style: uiTextStyle.text2,
                            ),
                          ],
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
