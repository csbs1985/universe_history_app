// ignore_for_file: use_key_in_widget_constructors, unnecessary_new, unused_element

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/comment_component.dart';
import 'package:universe_history_app/components/comment_empty_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class ModalCommentComponent extends StatelessWidget {
  final bool _comments = true;

  final Api api = new Api();

  _getContent() {
    return api.getAllComment();
  }

  void _showModal(BuildContext context, String historyId, bool openKeyboard) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => const ModalInputCommmentComponent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: uiColor.comp_1,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 48),
            child: _comments ? CommentComponent() : const CommentEmpty(),
          ),
          if (currentUser.value.isNotEmpty)
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const DividerComponent(
                    bottom: 0,
                  ),
                  GestureDetector(
                    child: const SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 10, 10),
                        child: Text(
                          "Escreva seu comentário...",
                          style: uiTextStyle.text2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    onTap: () {
                      _showModal(context, 'index', true);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
