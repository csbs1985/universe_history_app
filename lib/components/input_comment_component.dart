// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class InputCommentComponent extends StatefulWidget {
  const InputCommentComponent(this.openKeyboard);

  final bool openKeyboard;

  @override
  _InputCommentComponentState createState() => _InputCommentComponentState();
}

class _InputCommentComponentState extends State<InputCommentComponent> {
  final TextEditingController _commentController = TextEditingController();

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
      color: const Color(0Xff30363D),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _commentController,
            autofocus: widget.openKeyboard,
            minLines: 1,
            maxLines: 10,
            style: const TextStyle(fontSize: 20, color: Color(0XffC9D1D9)),
            decoration: const InputDecoration.collapsed(
              hintText: "Seu comentário pode ajudar alguém...",
              hintStyle: TextStyle(color: Color(0XffC9D1D9)),
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
        TextButton(
            child: _isComment ? Text('publicar') : Text(''),
            onPressed: () {
              _reset();
            }),
      ]),
    );
  }
}
