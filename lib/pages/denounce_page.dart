import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/firestore/denounce_firestore.dart';
import 'package:universe_history_app/models/denounce_justify_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:uuid/uuid.dart';

class DenouncePage extends StatefulWidget {
  const DenouncePage();

  @override
  State<DenouncePage> createState() => _DenouncePageState();
}

class _DenouncePageState extends State<DenouncePage> {
  final DenounceFirestore denounceFirestore = DenounceFirestore();
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

    Future<void> _setDenounce(bool value) async {
      _form = {
        'id': uuid.v4(),
        'userId': currentUser.value.first.id,
        'idDenounced': currentHistory.value.first.userId,
        'nickDenounced': currentHistory.value.first.userName,
        'code': justifySelected.id,
        'justify': justifySelected.title,
        'date': DateTime.now().toString(),
      };

      try {
        await denounceFirestore.postDenounce(_form);
        Navigator.of(context).pop();
        ActivityUtil(
          ActivitiesEnum.DENOUNCE.name,
          currentHistory.value.first.userName,
          _form['date'],
        );
        toast.toast(
          context,
          ToastEnum.SUCCESS.name,
          'Usuário ${currentHistory.value.first.userName} denunciado!',
        );
        Navigator.of(context).pop();
      } on AuthException catch (error) {
        debugPrint('ERROR => postDenounce: ' + error.toString());
      }
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
                  style: ButtonStyleEnum.PRIMARY.name,
                  size: ButtonSizeEnum.LARGE.name,
                  callback: (value) => _setDenounce(value),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
