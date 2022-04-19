// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_new, unused_local_variable

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/components/skeleton_comment_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/resume_util.dart';

class CommentComponent extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentComponent> {
  final Api api = new Api();
  final UserClass userClass = UserClass();

  List<CommentModel> documents = [];

  void _showModal(BuildContext context, dynamic _content) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ModalOptionsComponent(
        _content['id'],
        'comentário',
        _content['userId'],
        _content['userNickName'],
        _content['text'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 10, 16),
            child: Row(
              children: [
                if (currentHistory.value.first.qtyComment > 0)
                  AnimatedFlipCounter(
                    duration: Duration(milliseconds: 500),
                    value: currentHistory.value.first.qtyComment,
                    textStyle: uiTextStyle.text1,
                  ),
                Text(
                  currentHistory.value.first.qtyComment > 1
                      ? ' comentários'
                      : ' comentário',
                  style: uiTextStyle.text1,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: api.getAllComment(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const CommentEmpty();
                  case ConnectionState.waiting:
                    return SkeletonCommentComponent();
                  case ConnectionState.done:
                  default:
                    try {
                      return _list(context, snapshot);
                    } catch (e) {
                      return const CommentEmpty();
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Card(
                      color: uiColor.comp_3,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                        child: Text(
                          documents[index]['text'],
                          style: uiTextStyle.text1,
                        ),
                      ),
                    ),
                    onLongPress: () => _showModal(
                      context,
                      documents[index].data(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 4, 0, 0),
                    child: Text(
                      resumeUitl(documents[index]),
                      style: uiTextStyle.text2,
                    ),
                  )
                ],
              ),
            ),
          )
        : SkeletonCommentComponent();
  }
}
