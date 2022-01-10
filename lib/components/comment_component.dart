import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  bool _comments = false;

  @override
  void initState() {
    super.initState();
    print('idHistory: ' + id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _comments ? Text('Comentários') : CommentEmpty(),
    );
  }
}
