import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/services/firestore_database_service.dart';
import 'package:universe_history_app/models/denounce_justify_model.dart';
import 'package:universe_history_app/models/owner_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class DenouncePage extends StatefulWidget {
  const DenouncePage();

  @override
  State<DenouncePage> createState() => _DenouncePageState();
}

class _DenouncePageState extends State<DenouncePage> {
  final FirestoreDatabaseService api = FirestoreDatabaseService();
  final Uuid uuid = const Uuid();
  final ToastComponent toast = ToastComponent();
  final List<DenounceJustifyModel> _allDenounceJustify =
      DenounceJustifyModel.allDenounceJustify;

  bool _hasButton = false;

  late DenounceJustifyModel justifySelected;
  late Map<String, dynamic> _form;

  @override
  Widget build(BuildContext context) {
    void _onPressed(DenounceJustifyModel item) {
      setState(() {
        justifySelected = item;
        _hasButton = true;
      });
    }

    void _setDenounce(bool value) {
      _form = {
        'id': uuid.v4(),
        'userId': currentUser.value.first.id,
        'idDenounced': currentOwner.value.first.id,
        'nickDenounced': currentOwner.value.first.name,
        'code': justifySelected.id,
        'justify': justifySelected.title,
        'date': DateTime.now().toString(),
      };

      setState(
        () {
          api
              .setDenounce(_form)
              .then((result) => {
                    ActivityUtil(
                      ActivitiesEnum.DENOUNCE.name,
                      currentOwner.value.first.name,
                      _form['date'],
                    ),
                    toast.toast(
                        context, ToastEnum.SUCCESS.name, 'Usuário denunciado!'),
                    Navigator.of(context).pop(),
                    Navigator.of(context).pop(),
                  })
              .catchError((error) {});
        },
      );
    }

    return Scaffold(
      appBar: const AppbarBackComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleResumeComponent(
                'Denunciar',
                'Isso é algo sério, tenha certeza antes de denunciar alguém. Caso um usuário estiver em perigo à vida ou à saúde, peça ajuda imediatamente. Não espere.',
              ),
              BtnCardComponent(
                content: _allDenounceJustify,
                callback: (value) => _onPressed(value),
              ),
              const SizedBox(height: 20),
              if (_hasButton)
                Button3dComponent(
                  label: 'Denunciar',
                  style: ButtonStyleEnum.PRIMARY,
                  size: ButtonSizeEnum.LARGE,
                  callback: (value) => _setDenounce(value),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
