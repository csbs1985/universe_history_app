import 'package:flutter/material.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/title_component.dart';
import 'package:universe_history_app/pages/appbar_back_component.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  void _upAccount(String type) {
    print('deletado');
    // mudar status do usuário
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
              const TitleComponent('Deletar conta History'),
              const Text(
                'Tem certeza que deseja excluir sua conta History definitivamente? Você não poderá mais ler, editar e visualizar'
                ' suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.',
                style: uiTextStyle.text2,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const BtnCardComponent(
                  'Cancelar',
                  'Cancelar e seguir com sua conta History.',
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const BtnCardComponent(
                  'Desativar temporariamente',
                  'Dar uma tempo e mandar meu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta Apple ou Google cadastrada.',
                ),
                onTap: () => _upAccount('temp'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const BtnCardComponent(
                  'Justificar e deletar',
                  'Antes me diga o motivo do porque esta deletando sua conta.',
                ),
                onTap: () => Navigator.of(context).pushNamed("/justify"),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const BtnCardComponent(
                  'Deletar',
                  'Apenas deletar sua conta.',
                ),
                onTap: () => _upAccount('delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
