// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CallCreateComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escreva sua história, quem sabe alguém pode te ajudar.',
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
            onPressed: () {
              Navigator.of(context).pushNamed("/create");
            },
            style: uiButton.button1,
          ),
        ],
      ),
    );
  }
}
