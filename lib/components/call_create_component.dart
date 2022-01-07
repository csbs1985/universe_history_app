// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_colors.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CallCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escreva sua historia, quem sabe alguém pode te ajudar.',
          style: uiTextStyle.header1,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Todos nós temos uma história pra contar.',
          style: uiTextStyle.text1,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          child: const Text(
            'escrever',
            style: uiTextStyle.button1,
          ),
          onPressed: null,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.fromLTRB(20, 10, 20, 10)),
            backgroundColor: MaterialStateProperty.all<Color>(uiColor.first),
            foregroundColor: MaterialStateProperty.all<Color>(uiColor.first),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: uiColor.first),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
