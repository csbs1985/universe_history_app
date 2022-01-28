// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_button.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoginComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        elevation: 0,
        color: uiColor.comp_3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Entre ou crie sua conta',
                style: uiTextStyle.header2,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Você não se identificou ainda para escrever histórias e comentarios',
                style: uiTextStyle.text1,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                child: const Text(
                  'entrar',
                  style: uiTextStyle.button1,
                ),
                onPressed: () => Navigator.of(context).pushNamed("/login"),
                style: uiButton.button1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
