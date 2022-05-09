// ignore_for_file: use_key_in_widget_constructors

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/modal_comment_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/components/modal_options_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/owner_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryOptionsComponent extends StatefulWidget {
  const HistoryOptionsComponent(
      {required QueryDocumentSnapshot<dynamic> history})
      : _history = history;

  final QueryDocumentSnapshot<dynamic> _history;

  @override
  State<HistoryOptionsComponent> createState() =>
      _HistoryOptionsComponentState();
}

class _HistoryOptionsComponentState extends State<HistoryOptionsComponent> {
  final Api api = Api();
  final CommentClass commentClass = CommentClass();
  final HistoryClass historyClass = HistoryClass();
  final OwnerClass ownerClass = OwnerClass();

  void _selectHistory(Map<String, dynamic> _history) {
    ownerClass.selectOwner(
      _history['userId'],
      _history['userNickName'],
      _history['token'],
      _history['statusUser'],
    );
    historyClass.selectHistory(_history);
  }

  void _showModal(BuildContext context, String type) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => type == 'inputCommentary'
          ? const ModalInputCommmentComponent()
          : ModalCommentComponent(),
    );
  }

  bool _getBookmark(String id) {
    return currentBookmarks.value.contains(id) ? true : false;
  }

  void _toggleBookmark(String id) {
    setState(() {
      currentBookmarks.value.contains(id)
          ? currentBookmarks.value.remove(id)
          : currentBookmarks.value.add(id);
    });

    api.upBookmarks();
  }

  void _showModalOptions(BuildContext context, dynamic _content) {
    ownerClass.selectOwner(
      _content['userId'],
      _content['userNickName'],
      _content['token'],
      _content['statusUser'],
    );

    commentClass.selectComment(_content);

    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ModalOptionsComponent(
        _content['id'],
        'história',
        _content['userId'],
        _content['userNickName'],
        _content['text'],
        _content['isDelete'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        widget._history['qtyComment'] < 1
            ? const SizedBox()
            : TextButton(
                child: Row(
                  children: [
                    AnimatedFlipCounter(
                      duration: const Duration(milliseconds: 500),
                      value: widget._history['qtyComment'],
                      textStyle: uiTextStyle.text2,
                    ),
                    Text(
                      widget._history['qtyComment'] > 1
                          ? ' comentários'
                          : ' comentário',
                      style: uiTextStyle.text2,
                    ),
                  ],
                ),
                onPressed: () {
                  _selectHistory(widget._history.data());
                  _showModal(context, 'listCommentary ');
                },
              ),
        ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (context, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget._history['isComment'] &&
                    currentUser.value.isNotEmpty)
                  IconComponent(
                      icon: uiSvg.comment,
                      callback: (value) {
                        setState(() {
                          _selectHistory(widget._history.data());
                          _showModal(context, 'inputCommentary');
                        });
                      }),
                if (currentUser.value.isNotEmpty)
                  ValueListenableBuilder(
                    valueListenable: currentBookmarks,
                    builder: (BuildContext context, value, __) {
                      return IconComponent(
                        icon: _getBookmark(widget._history['id'])
                            ? uiSvg.favorited
                            : uiSvg.favorite,
                        callback: (value) {
                          _toggleBookmark(
                            widget._history['id'],
                          );
                        },
                      );
                    },
                  ),
                IconComponent(
                    icon: uiSvg.open,
                    callback: (value) {
                      _selectHistory(widget._history.data());
                      Navigator.pushNamed(context, '/history',
                          arguments: widget._history.data()['id']);
                    }),
                IconComponent(
                  icon: uiSvg.options,
                  callback: (value) => {
                    _selectHistory(widget._history.data()),
                    _showModalOptions(context, widget._history.data()),
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
