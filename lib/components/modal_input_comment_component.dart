// ignore_for_file: prefer_is_empty, unused_field

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
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
  final String buttonText = 'publicar';
  bool _isInputNotEmpty = false;
  bool _textAnonimous = false;
  final bool _comments = true;

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
    _commentController.clear();
    setState(() {
      _isInputNotEmpty = false;
      Navigator.of(context).pop();
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
