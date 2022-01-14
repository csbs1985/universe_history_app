// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent(this.id);

  final String id;

  @override
  _CommentState createState() => _CommentState(id);
}

class _CommentState extends State<CommentComponent> {
  _CommentState(this.id);
  final List<CommentModel> allComment = CommentModel.allComment;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 16),
          child: Text(
            allComment.length > 1
                ? allComment.length.toString() + ' comentários'
                : '1 comentário',
            style: uiTextStyle.text1,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allComment.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Card(
                      color: uiColor.comp_1,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Text(
                          allComment[index].text,
                          style: uiTextStyle.text1,
                        ),
                      ),
                    ),
                    onLongPress: () {
                      print('por que esta apertando tanto?');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      allComment[index].date + ' - ' + allComment[index].user,
                      style: uiTextStyle.text2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
