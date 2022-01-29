// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, prefer_is_empty, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class InputCommentComponent extends StatefulWidget {
  const InputCommentComponent(this.openKeyboard);

  final bool openKeyboard;

  @override
  _InputCommentComponentState createState() => _InputCommentComponentState();
}

class _InputCommentComponentState extends State<InputCommentComponent> {
  final TextEditingController _commentController = TextEditingController();
  final String buttonText = 'publicar';

  bool _textExpanded = false;
  bool _isInputNotEmpty = false;
  bool _textAnonimous = false;

  void keyUp(String text) {
    setState(() {
      _isInputNotEmpty = _commentController.text.length > 0 ? true : false;
    });
  }

  void _toggleTextExpanded() {
    setState(() {
      _textExpanded = !_textExpanded;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: uiColor.comp_1,
        border: Border(
          top: BorderSide(
            color: uiColor.comp_3,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: _commentController,
              onChanged: (value) => keyUp(value),
              autofocus: false,
              maxLines: 2,
              style: uiTextStyle.text4,
              decoration: const InputDecoration.collapsed(
                hintText: "Seu comentário...",
                hintStyle: uiTextStyle.text2,
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconComponent(
                      svg: _textExpanded ? uiSvg.minimize : uiSvg.maximize,
                      callback: (value) => _toggleTextExpanded(),
                    ),
                    IconComponent(
                      svg: _textAnonimous ? uiSvg.lock : uiSvg.unlock,
                      callback: (value) => _toggleAnonimous(),
                    ),
                  ],
                ),
                Container(
                  height: 48,
                  color: uiColor.comp_1,
                  child: BtnComponent(
                    enabled: _isInputNotEmpty,
                    callback: (value) => _sendComment(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
