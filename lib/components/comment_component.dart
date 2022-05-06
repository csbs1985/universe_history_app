// ignore_for_file: no_logic_in_create_state, prefer_final_fields, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_new, unused_local_variable, curly_braces_in_flow_control_structures

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
import 'package:universe_history_app/shared/models/owner_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_border.dart';
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
  final OwnerClass ownerClass = OwnerClass();

  List<CommentModel> documents = [];

  void _showModal(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content['userId'],
      _content['userNickName'],
      _content['userStatus'],
      _content['token'],
    );

    CommentClass.selectComment(_content);

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
        _content['isDelete'],
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
                ValueListenableBuilder(
                  valueListenable: currentHistory,
                  builder: (BuildContext context, value, __) {
                    return Text(
                      currentHistory.value.first.qtyComment > 1
                          ? ' comentários'
                          : ' comentário',
                      style: uiTextStyle.text1,
                    );
                  },
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

  bool _canShowOption(dynamic _content) {
    if (currentUser.value.first.id == _content['userId']) {
      if (!_content['isDelete']) return true;
    } else {
      if (!_content['isDelete']) return true;
    }
    return false;
  }

  Color _getBackColor(String _text) {
    return _text.contains('@' + currentUser.value.first.nickname)
        ? uiColor.second
        : uiColor.comp_3;
  }

  Widget _list(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return documents.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Card(
                      color: _getBackColor(documents[index]['text']),
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(uiBorder.rounded)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                        child: documents[index]['isDelete']
                            ? Text('Comentário apagado!'.toUpperCase(),
                                style: uiTextStyle.text8)
                            : Text(documents[index]['text'],
                                style: uiTextStyle.text1),
                      ),
                    ),
                    onLongPress: _canShowOption(documents[index].data())
                        ? () => _showModal(context, documents[index].data())
                        : null,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(2, 4, 0, 0),
                      child: Text(
                          resumeUitl(documents[index],
                              type: ContentType.COMMENT
                                  .toString()
                                  .split('.')
                                  .last),
                          style: uiTextStyle.text2))
                ],
              ),
            ),
          )
        : SkeletonCommentComponent();
  }
}
