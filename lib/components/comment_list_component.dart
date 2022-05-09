// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_new, unused_local_variable, curly_braces_in_flow_control_structures, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/comment_item_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';

class CommentListComponent extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentListComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: CommentItemComponent(type: HistoryOptionsType.HOMEPAGE),
    );
  }
}
