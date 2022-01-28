import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/shared/models/justtify_model.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final List<JustifyModel> allJustify = JustifyModel.allJustify;

  void _onPressed(String id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleResumeComponent(
                'Justificar e deletar',
                'Antes me diga o motivo do porque esta deletando sua conta History.',
              ),
              BtnCardComponent(
                content: allJustify,
                callback: (value) => _onPressed(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
