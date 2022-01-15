// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/components/button_disabled.component.dart';
import 'package:universe_history_app/services/variable.global.dart';
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

  FocusNode inputNode = FocusNode();

  bool _textField = false;
  bool _textEmpty = true;
  bool _textAnonimous = false;

  void keyUp(String text) {
    setState(() {
      _textEmpty = _commentController.text.length > 0 ? false : true;
    });
  }

  void _toggleTextField() {
    setState(() {
      _textField = !_textField;
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
      _textEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: uiColor.second,
        border: Border(
          top: BorderSide(
            color: uiColor.comp_1,
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
                    IconButton(
                        icon: _textAnonimous
                            ? SvgPicture.asset(uiSvg.minimize)
                            : SvgPicture.asset(uiSvg.maximize),
                        onPressed: () => _toggleAnonimous()),
                    IconButton(
                        icon: _textField
                            ? SvgPicture.asset(uiSvg.lock)
                            : SvgPicture.asset(uiSvg.unlock),
                        onPressed: () => _toggleTextField()),
                  ],
                ),
                _textEmpty
                    ? ButtonDisabledComponent(buttonText)
                    : TextButton(
                        child: Text(
                          buttonText,
                          style: uiTextStyle.button2,
                        ),
                        onPressed: () {
                          _sendComment();
                        }),
              ],
            ),
        ],
      ),
    );
  }
}
