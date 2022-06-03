// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
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
    required history,
    required String type,
  })  : _history = history,
        _type = type;

  final _history;
  final String _type;

  @override
  State<HistoryOptionsComponent> createState() =>
      _HistoryOptionsComponentState();
}

class _HistoryOptionsComponentState extends State<HistoryOptionsComponent> {
  final Api api = Api();
  final CommentClass commentClass = CommentClass();
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
    historyClass.selectHistory(_history);
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
    historyClass.selectHistory(_content);

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
                    valueListenable: currentBookmarks,
                    builder: (BuildContext context, value, __) {
                      return IconComponent(
                        icon: _getBookmark(widget._history['id'])
                            ? UiSvg.favorited
                            : UiSvg.favorite,
                        callback: (value) {
                          _toggleBookmark(widget._history['id']);
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
