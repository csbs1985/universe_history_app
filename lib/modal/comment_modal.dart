import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/models/history_model.dart';

class CommentModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CommentListComponent(
              type: HistoryOptionsType.HOMEPAGE.name,
            ),
          ),
          const BtnCommentComponent()
        ],
      ),
    );
  }
}
