// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/input_comment_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ModalCommentComponent extends StatefulWidget {
  const ModalCommentComponent({Key? key}) : super(key: key);

  @override
  _ModalCommentComponentState createState() => _ModalCommentComponentState();

  static showModal(BuildContext context, String id) {
    double size = MediaQueryData.fromWindow(window).padding.top.toDouble();

    bool _comments = false;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(top: size),
            child: Container(
              decoration: const BoxDecoration(
                color: uiColor.second,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CommentEmpty(),
                  InputCommentComponent(),
                ],
              ),
            ),
          );
        });
  }
}

class _ModalCommentComponentState extends State<ModalCommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
