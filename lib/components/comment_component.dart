import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';

class CommentComponent extends StatefulWidget {
  const CommentComponent({Key? key}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentComponent> {
  bool _comments = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _comments ? Text('Comentários') : CommentEmpty(),
    );
  }
}
