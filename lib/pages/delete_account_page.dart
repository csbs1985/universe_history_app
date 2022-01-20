import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/pages/appbar_back_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
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
              const TitleComponent('Deletar conta History'),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    const Text(
                      'Tem certeza que deseja excluir sua conta History definitivamente? Você não poderá mais ler, editar e visualizar'
                      ' suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.',
                      style: uiTextStyle.text2,
                    ),
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
