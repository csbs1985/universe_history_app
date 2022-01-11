// ignore_for_file: avoid_unnecessary_containers, dead_code, use_key_in_widget_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/input_comment_component.dart';
import 'package:universe_history_app/theme/ui_color.dart';

class ModalCommentComponent extends StatefulWidget {
  const ModalCommentComponent(this.openKeyboard);

  final bool openKeyboard;

  @override
  _ModalCommentComponentState createState() => _ModalCommentComponentState();

  static showModal(BuildContext context, String id, bool openKeyboard) {
    bool _comments = true;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: uiColor.comp_1,
      ),
    );

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).padding.top),
            child: Container(
              decoration: const BoxDecoration(
                color: uiColor.second,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  Flexible(
                    flex: 1,
                    child:
                        _comments ? CommentComponent(id) : const CommentEmpty(),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: InputCommentComponent(openKeyboard),
                  ),
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
