// ignore_for_file: todo, avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/shared/models/delete_account_model.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final List<DeleteAccountModel> allDeleteAccount =
      DeleteAccountModel.allDeleteAccount;

  void _onPressed(DeleteAccountModel item) {
    switch (item.id) {
      case '0':
        Navigator.of(context).pop();
        break;
      case '1':
        _upAccount('temp');
        break;
      case '2':
        Navigator.of(context).pushNamed("/justify");
        break;
      case '3':
        _upAccount('delete');
        break;
      default:
    }
  }

  void _upAccount(String type) {
    print('deletado');
    //TODO: mudar status do usuário
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleResumeComponent(
                'Deletar conta History',
                'Tem certeza que deseja excluir sua conta History definitivamente? Você não poderá mais ler, editar e visualizar suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.',
              ),
              BtnCardComponent(
                content: allDeleteAccount,
                callback: (value) => _onPressed(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
