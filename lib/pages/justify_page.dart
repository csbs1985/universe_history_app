// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_primary_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/shared/models/justtify_model.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final List<JustifyModel> allJustify = JustifyModel.allJustify;
  bool _btnDelete = false;

  late JustifyModel justifySelected;

  void _onPressed(JustifyModel item) {
    setState(() {
      justifySelected = item;
      _btnDelete = true;
    });
  }

  void _onDelete(bool value) {
    setState(() {
      print('conta deletada');
      Navigator.of(context).pushNamed("/home");
    });
  }

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
              const SizedBox(
                height: 20,
              ),
              BtnPrimaryComponent(
                label: 'Justificar e deletar',
                enabled: _btnDelete,
                callback: (value) => _onDelete(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
