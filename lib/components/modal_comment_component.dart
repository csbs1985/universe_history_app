// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/input_comment_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ModalCommentComponent extends StatelessWidget {
  const ModalCommentComponent(this.historyId, this.openKeyboard);

  final String historyId;
  final bool openKeyboard;
  final bool _comments = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 48),
            child:
                _comments ? CommentComponent(historyId) : const CommentEmpty(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: InputCommentComponent(openKeyboard),
          ),
        ],
      ),
    );
  }
}
