// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/alert_confirm_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/justtify_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:uuid/uuid.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final Api api = Api();
  final UserClass userClass = UserClass();
  final Uuid uuid = const Uuid();
  final List<JustifyModel> _allJustify = JustifyModel.allJustify;

  bool _hasButton = false;
  JustifyModel? _justifySelected;

  late Map<String, dynamic> _form;

  void _selected(JustifyModel item) {
    setState(() {
      _justifySelected = item;
      _hasButton = true;
    });
  }

  void _onPressed() {
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
              callback: (value) => _return(value));
        });
  }

  void _return(bool _status) {
    return !_status ? Navigator.of(context).pop() : _justify(_status);
  }

  Future<void> _justify(bool _status) async {
    Navigator.of(context).pop();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    _form = {
      'id': uuid.v4(),
      'date': DateTime.now().toString(),
      'idUser': currentUser.value.first.id,
      'nicknameUser': currentUser.value.first.nickname,
      'idJustify': _justifySelected!.id,
      'titleJustify': _justifySelected!.title
    };

    await api
        .setJustify(_form)
        .then((result) => _deletetAllHistory(_status))
        .catchError((error) => {print('ERROR:' + error)});
  }

  Future<void> _deletetAllHistory(bool _status) async {
    await api
        .getAllUserHistory()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.deleteHistory(item['id']),
              _upAllComment()
            })
        .catchError((error) => print('ERROR:' + error.toString()));
  }

  Future<void> _upAllComment() async {
    await api
        .getAllUserComment()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.upStatusUserComment(item['id']),
              userClass.delete()
            })
        .catchError((error) => print('ERROR:' + error.toString()));
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
                  callback: (value) => _onPressed(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
