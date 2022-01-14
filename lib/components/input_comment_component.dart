// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/theme/ui_color.dart';
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

  bool _isComment = false;

  void _reset() {
    _commentController.clear();
    setState(() {
      _isComment = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: uiColor.comp_1,
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              autofocus: widget.openKeyboard,
              minLines: 1,
              maxLines: 10,
              style: uiTextStyle.text4,
              decoration: const InputDecoration.collapsed(
                hintText: "Seu comentário pode ajudar alguém...",
                hintStyle: uiTextStyle.text2,
              ),
              onChanged: (text) {
                setState(() {
                  _isComment = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                _reset();
              },
            ),
          ),
          !_isComment
              ? ButtonDisabledComponent(buttonText)
              : TextButton(
                  child: Text(
                    buttonText,
                    style: uiTextStyle.button2,
                  ),
                  onPressed: () {
                    _reset();
                  })
        ]),
      ),
    );
  }
}
