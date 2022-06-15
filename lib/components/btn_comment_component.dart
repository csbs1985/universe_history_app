import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/modal/input_comment_modal.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class BtnCommentComponent extends StatefulWidget {
  const BtnCommentComponent({Key? key}) : super(key: key);

  @override
  State<BtnCommentComponent> createState() => _BtnCommentComponentState();
}

class _BtnCommentComponentState extends State<BtnCommentComponent> {
  void _showModal(BuildContext context, String historyId, bool openKeyboard) {
    showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) => const InputCommmentModal());
  }

  bool _isShow() {
    return currentHistory.value.first.isComment && currentUser.value.isNotEmpty
        ? false
        : true;
  }

  @override
  Widget build(BuildContext context) {
    return _isShow()
        ? const SizedBox()
        : Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const DividerComponent(bottom: 0),
                GestureDetector(
                  child: Container(
                    color: UiColor.comp_1,
                    width: double.infinity,
                    height: UiSize.input,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Escrever comentário...",
                        style: UiTextStyle.text1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  onTap: () => _showModal(context, 'index', true),
                ),
              ],
            ),
          );
  }
}
