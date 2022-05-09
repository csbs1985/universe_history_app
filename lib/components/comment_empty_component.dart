// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/no_history_component.dart';

class CommentEmpty extends StatelessWidget {
  const CommentEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Center(
        child: NoResultComponent(
          text: 'Nenhum comentário ainda, ou os comentários foram desativados.',
        ),
      ),
    );
  }
}
