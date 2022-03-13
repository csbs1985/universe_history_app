// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, unused_element

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_comment_component.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ModalCommentComponent extends StatelessWidget {
  final Api api = new Api();
  final UserClass userClass = UserClass();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 48),
            child: CommentComponent(),
          ),
          if (currentUser.value.isNotEmpty) const BtnCommentComponent(),
        ],
      ),
    );
  }
}
