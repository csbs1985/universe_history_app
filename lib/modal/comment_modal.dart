import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_list_component.dart';

class CommentModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          CommentListComponent(),
          const BtnCommentComponent(),
        ],
      ),
    );
  }
}
