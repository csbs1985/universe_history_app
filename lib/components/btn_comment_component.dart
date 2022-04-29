import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/modal_input_comment_component.dart';
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
      builder: (context) => const ModalInputCommmentComponent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Container(
        color: uiColor.comp_1,
        child: Column(
          children: [
            const DividerComponent(
              bottom: 0,
            ),
            GestureDetector(
              child: const SizedBox(
                width: double.infinity,
                height: uiSize.input,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 10, 10),
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
    );
  }
}
