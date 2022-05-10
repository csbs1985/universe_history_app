// ignore_for_file: use_key_in_widget_constructors, unused_field, curly_braces_in_flow_control_structures, unused_element

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/history_options_component.dart';
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

class CommentItemComponent extends StatefulWidget {
  const CommentItemComponent({required HistoryOptionsType type}) : _type = type;

  final HistoryOptionsType _type;

  @override
  State<CommentItemComponent> createState() => _CommentItemComponentState();
}

class _CommentItemComponentState extends State<CommentItemComponent> {
  final Api api = Api();
  final OwnerClass ownerClass = OwnerClass();
  final CommentClass commentClass = CommentClass();

  void _showModal(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content['userId'],
      _content['userNickName'],
      _content['userStatus'],
      _content['token'],
    );

    commentClass.selectComment(_content);

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

  bool _canShowOption(dynamic _content) {
    if (currentUser.value.first.id == _content['userId']) {
      if (!_content['isDelete']) return true;
    } else {
      if (!_content['isDelete']) return true;
    }
    return false;
  }

  Color _getBackColor(_index) {
    if (_index['text'].contains('@' + currentUser.value.first.nickname))
      return uiColor.first;
    if (_index['userId'] == currentUser.value.first.id) return uiColor.second;
    return uiColor.comp_3;
  }

  double _getHeightPaddingBottom(bool _isComment) {
    return _isComment && currentUser.value.isNotEmpty
        ? MediaQuery.of(context).viewInsets.bottom + 48
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: api.getAllComment(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const CommentEmpty();
          case ConnectionState.waiting:
            return const SkeletonCommentComponent();
          case ConnectionState.done:
          default:
            try {
              return SingleChildScrollView(child: _list(context, snapshot));
            } catch (e) {
              return const CommentEmpty();
            }
        }
      },
    );
  }

  Widget _list(BuildContext context, snapshot) {
    List<QueryDocumentSnapshot<dynamic>> documents = snapshot.data!.docs;
    return !documents.isNotEmpty
        ? const CommentEmpty()
        : Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 48),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (widget._type == HistoryOptionsType.HOMEPAGE)
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(children: [
                      if (currentHistory.value.first.qtyComment > 0)
                        AnimatedFlipCounter(
                            duration: const Duration(milliseconds: 500),
                            value: currentHistory.value.first.qtyComment,
                            textStyle: uiTextStyle.text1),
                      ValueListenableBuilder(
                          valueListenable: currentHistory,
                          builder: (BuildContext context, value, __) {
                            return Text(
                                currentHistory.value.first.qtyComment > 1
                                    ? ' comentários'
                                    : ' comentário',
                                style: uiTextStyle.text1);
                          })
                    ])),
              for (var item in documents)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  GestureDetector(
                    child: Card(
                      color: _getBackColor(item),
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(uiBorder.rounded)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                        child: item['isDelete']
                            ? Text('Comentário apagado!'.toUpperCase(),
                                style: uiTextStyle.text8)
                            : Text(item['text'], style: uiTextStyle.text1),
                      ),
                    ),
                    onLongPress: _canShowOption(item.data())
                        ? () => _showModal(context, item.data())
                        : null,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(2, 4, 0, 16),
                      child: Text(
                          resumeUitl(item,
                              type: ContentType.COMMENT
                                  .toString()
                                  .split('.')
                                  .last),
                          style: uiTextStyle.text2)),
                ])
            ]));
  }
}
