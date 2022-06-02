import 'package:flutter/material.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/models/history_model.dart';

class CommentListComponent extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentListComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: CommentItemComponent(type: HistoryOptionsType.HOMEPAGE.name),
    );
  }
}
