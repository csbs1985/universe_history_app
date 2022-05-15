// ignore_for_file: todo, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/alert_confirm_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/pages/justify_page.dart';
import 'package:universe_history_app/shared/models/delete_account_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/utils/delete_account_util.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final UserClass userClass = UserClass();
  final JustifyPage justifyPage = JustifyPage();
  final DeleteAccountUtil deleteAccountUtil = DeleteAccountUtil();

  final List<DeleteAccountModel> _allDeleteAccount =
      DeleteAccountModel.allDeleteAccount;

  void _onPressed(DeleteAccountModel item) {
    switch (item.id) {
      case '0':
        Navigator.of(context).pop();
        break;
      case '1':
        _disableAccount();
        break;
      case '2':
        Navigator.of(context).pushNamed("/justify");
        break;
      case '3':
        _showDialog();
        break;
      default:
    }
  }

  void _disableAccount() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertConfirmComponent(
            title: 'Desativar temporariamente',
            text:
                'Dar uma tempo e manter meu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta Apple ou Google cadastrada.',
            btnPrimaryLabel: 'Cancelar',
            btnSecondaryLabel: 'Desativar',
            callback: (value) => {
              !value
                  ? Navigator.of(context).pop()
                  : userClass.clean(
                      context, UserStatus.DISABLED.toString().split('.').last)
            },
          );
        });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertConfirmComponent(
              title: 'Deletar',
              text:
                  'Tem certeza que deseja excluir sua conta History definitivamente? Você não poderá mais ler, editar e visualizar suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.',
              btnPrimaryLabel: 'Cancelar',
              btnSecondaryLabel: 'Deletar',
              callback: (value) => !value
                  ? Navigator.of(buildContext).pop()
                  : deleteAccountUtil.deleteAccount(buildContext, null));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                content: _allDeleteAccount,
                callback: (value) => _onPressed(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
