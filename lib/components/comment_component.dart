// ignore_for_file: no_logic_in_create_state, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';

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
  void initState() {
    super.initState();
    print('idHistory: ' + id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        children: const [
          CommentEmpty(),
        ],
      ),
    );
  }
}
