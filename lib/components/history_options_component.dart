// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/modal/comment_modal.dart';
import 'package:universe_history_app/modal/input_comment_modal.dart';
import 'package:universe_history_app/modal/options_modal.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class HistoryOptionsComponent extends StatefulWidget {
  const HistoryOptionsComponent({
    required Map<String, dynamic> history,
    required String type,
  })  : _history = history,
        _type = type;

  final Map<String, dynamic> _history;
  final String _type;

  @override
  State<HistoryOptionsComponent> createState() =>
      _HistoryOptionsComponentState();
}

class _HistoryOptionsComponentState extends State<HistoryOptionsComponent> {
  final CommentClass commentClass = CommentClass();
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final HistoryClass historyClass = HistoryClass();

  bool _showComments(int _qtyComment) {
    return _qtyComment > 0 ? true : false;
  }

  String _fillComment(int _qtyComment) {
    return _qtyComment > 1 ? ' comentários' : ' comentário';
  }

  bool _showComment(bool _isComment) {
    return widget._type == HistoryOptionsType.HOMEPAGE.name &&
            _isComment &&
            currentUser.value.isNotEmpty
        ? true
        : false;
  }

  bool _showBookmark() {
    return currentUser.value.isNotEmpty ? true : false;
  }

  bool _showOpen() {
    return widget._type == HistoryOptionsType.HOMEPAGE.name ? true : false;
  }

  void _selectHistory(_history) {
    historyClass.add(_history);
  }

  void _showModal(BuildContext context, String type) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => type == 'inputCommentary'
          ? const InputCommmentModal()
          : CommentModal(),
    );
  }

  bool _getBookmark(_history) {
    return _history['bookmarks'].contains(currentUser.value.first.id)
        ? true
        : false;
  }

  void _toggleBookmark(_history) {
    setState(() {
      _history['bookmarks'].contains(currentUser.value.first.id)
          ? _history['bookmarks'].remove(currentUser.value.first.id)
          : _history['bookmarks'].add(currentUser.value.first.id);

      historiesFirestore.pathBookmark(_history);
    });
  }

  void _showModalOptions(BuildContext context, dynamic _content) {
    historyClass.add(_content);

    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => OptionsModal(
        _content['id'],
        'história',
        _content['userId'],
        _content['userName'],
        _content['text'],
        false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !_showComments(widget._history['qtyComment'])
            ? Container()
            : TextButton(
                child: Row(
                  children: [
                    if (widget._history['qtyComment'] > 0)
                      AnimatedFlipCounter(
                        duration: const Duration(milliseconds: 500),
                        value: widget._history['qtyComment'],
                        textStyle: UiTextStyle.text2,
                      ),
                    Text(
                      _fillComment(widget._history['qtyComment']),
                      style: UiTextStyle.text2,
                    )
                  ],
                ),
                onPressed: () {
                  if (widget._type == HistoryOptionsType.HOMEPAGE.name) {
                    _selectHistory(widget._history);
                    _showModal(context, 'listCommentary');
                  }
                },
              ),
        ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (context, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_showComment(widget._history['isComment']))
                  IconComponent(
                    icon: UiSvg.comment,
                    callback: (value) {
                      setState(
                        () {
                          _selectHistory(widget._history);
                          _showModal(context, 'inputCommentary');
                        },
                      );
                    },
                  ),
                if (_showBookmark())
                  ValueListenableBuilder(
                    valueListenable: currentHistory,
                    builder: (BuildContext context, value, __) {
                      return IconComponent(
                        icon: _getBookmark(widget._history)
                            ? UiSvg.favorited
                            : UiSvg.favorite,
                        callback: (value) {
                          _toggleBookmark(widget._history);
                        },
                      );
                    },
                  ),
                if (_showOpen())
                  IconComponent(
                    icon: UiSvg.open,
                    callback: (value) {
                      _selectHistory(widget._history);
                      Navigator.pushNamed(context, '/history',
                          arguments: widget._history['id']);
                    },
                  ),
                IconComponent(
                  icon: UiSvg.options,
                  callback: (value) => {
                    _selectHistory(widget._history),
                    _showModalOptions(context, widget._history)
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
