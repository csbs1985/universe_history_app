// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class CallCreateComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0,
        color: uiColor.comp_3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Escreva sua história',
                style: uiTextStyle.header2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Todos nós temos uma história pra contar. Quem sabe alguém pode te ajudar.',
                style: uiTextStyle.text7,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                child: const Text(
                  'Escrever',
                  style: uiTextStyle.button1,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/create");
                },
                style: uiButton.button1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
