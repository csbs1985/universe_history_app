// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, unused_element

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/shared/models/user_model.dart';

class ModalCommentComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: currentUser.value.isNotEmpty
                ? EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 48)
                : null,
            child: CommentComponent(),
          ),
          if (currentUser.value.isNotEmpty) const BtnCommentComponent(),
        ],
      ),
    );
  }
}
