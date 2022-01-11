// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent(this.id);

  final String id;

  @override
  _CommentState createState() => _CommentState(id);
}

class _CommentState extends State<CommentComponent> {
  _CommentState(this.id);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('data')],
    );
  }
}
