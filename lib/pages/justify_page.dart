import 'package:flutter/material.dart';
import 'package:universe_history_app/components/select_card_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/shared/models/justtify_model.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final List<JustifyModel> allJustify = JustifyModel.allJustify;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleComponent('Justificar e deletar'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    const Text(
                      'Antes me diga o motivo do porque esta deletando sua conta History.',
                      style: uiTextStyle.text2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SelectCardComponent(allJustify),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
