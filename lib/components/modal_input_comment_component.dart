// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
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
  final ToastComponent toast = new ToastComponent();
  final UserClass userClass = UserClass();
  final Api api = Api();
  final Uuid uuid = const Uuid();

  final bool _comments = true;
  late Map<String, dynamic> _comment;

  bool _isInputNotEmpty = false;
  bool _textAnonimous = false;

  void keyUp(String text) {
    setState(() {
      _isInputNotEmpty = _commentController.text.length > 0 ? true : false;
    });
  }

  dynamic _toggleAnonimous() {
    setState(() {
      _textAnonimous = !_textAnonimous;
    });
  }

  void _sendComment() {
    setState(() {
      _comment = {
        'id': uuid.v4(),
        'date': DateTime.now().toString(),
        'historyId': currentHistory.value.first.id,
        'isAnonymous': _textAnonimous,
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
                    _commentController.text, result.id),
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

  void _cleanComment() {
    setState(() {
      _commentController.text = '';
      _isInputNotEmpty = false;
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 48),
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
              height: 48.5,
              color: uiColor.comp_1,
              child: Column(
                children: [
                  const DividerComponent(bottom: 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconComponent(
                              icon: uiSvg.cleanAll,
                              callback: (value) => _cleanComment(),
                            ),
                            TextButton.icon(
                              icon: _textAnonimous
                                  ? SvgPicture.asset(uiSvg.lock)
                                  : SvgPicture.asset(uiSvg.unlock),
                              label: Text(
                                _textAnonimous
                                    ? 'anônimo'
                                    : currentUser.value.first.nickname,
                                style: uiTextStyle.text2,
                              ),
                              onPressed: () => _toggleAnonimous(),
                            ),
                          ],
                        ),
                        BtnComponent(
                          enabled: _isInputNotEmpty,
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
