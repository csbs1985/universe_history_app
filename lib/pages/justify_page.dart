import 'package:flutter/material.dart';
import 'package:universe_history_app/components/alert_confirm_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/models/justtify_model.dart';
import 'package:universe_history_app/utils/delete_account_util.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final DeleteAccountUtil deleteAccountUtil = DeleteAccountUtil();
  final List<JustifyModel> _allJustify = JustifyModel.allJustify;

  bool _hasButton = false;
  JustifyModel? justifySelected;

  void _selected(JustifyModel item) {
    setState(() {
      justifySelected = item;
      _hasButton = true;
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertConfirmComponent(
              title: 'Justificar e deletar',
              text:
                  'Antes me diga o motivo do porque esta deletando sua conta History.',
              btnPrimaryLabel: 'Cancelar',
              btnSecondaryLabel: 'Deletar',
              callback: (value) => !value
                  ? Navigator.of(context).pop()
                  : deleteAccountUtil.deleteAccount(context, justifySelected));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleResumeComponent(
                'Justificar e deletar',
                'Antes me diga o motivo do porque esta deletando sua conta History.',
              ),
              BtnCardComponent(
                content: _allJustify,
                callback: (value) => _selected(value),
              ),
              const SizedBox(height: 20),
              if (_hasButton)
                Button3dComponent(
                  label: 'Justificar e deletar',
                  style: ButtonStyleEnum.PRIMARY,
                  size: ButtonSizeEnum.LARGE,
                  callback: (value) => _showDialog(context),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
