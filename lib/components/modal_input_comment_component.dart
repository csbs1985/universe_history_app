// ignore_for_file: prefer_is_empty, unused_field, void_checks, avoid_print, unnecessary_new

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

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
  final bool _comments = true;
  late String buttonText;
  bool _isInputNotEmpty = false;
  bool _textAnonimous = false;
  late CommentModel form;

  final Api api = Api();

  // @override
  // void initState() {
  //   super.initState();
  //   return api.getAllComment(currentHistory.value.historyId).then((result)=> );
  // }

  void keyUp(String text) {
    setState(() {
      _isInputNotEmpty = _commentController.text.length > 0 ? true : false;
    });
  }

  void _toggleAnonimous() {
    setState(() {
      _textAnonimous = !_textAnonimous;
    });
  }

  void _sendComment() {
    form = {
      'date': DateTime.now(),
      // 'historyId': currentHistory.value.id,
      'isAnonymous': _textAnonimous,
      'isEdit': false,
      'text': _commentController.text,
      'userId': getCurrentId(),
      'userNickName': getCurrentId(),
    } as CommentModel;

    _commentController.clear();

    api
        .setComment(form)
        .then((result) => {
              _isInputNotEmpty = false,
              Navigator.of(context).pop(),
              toast.toast(
                  context, ToastEnum.SUCCESS, 'Seu comentário foi publicado.'),
            })
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 48),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: TextField(
                    controller: _commentController,
                    onChanged: (value) => keyUp(value),
                    autofocus: false,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconComponent(
                        icon: _textAnonimous ? uiSvg.lock : uiSvg.unlock,
                        callback: (value) => _toggleAnonimous(),
                      ),
                      BtnComponent(
                        enabled: _isInputNotEmpty,
                        callback: (value) => _sendComment(),
                      ),
                    ],
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
