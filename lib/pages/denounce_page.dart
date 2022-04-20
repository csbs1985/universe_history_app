// ignore_for_file: unused_field, prefer_typing_uninitialized_variables, void_checks, unused_element

import 'package:flutter/material.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_card_component.dart';
import 'package:universe_history_app/components/button_3d_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/denounceJustify_model.dart';
import 'package:universe_history_app/shared/models/owner_model.dart';
import 'package:uuid/uuid.dart';

class DenouncePage extends StatefulWidget {
  const DenouncePage();

  @override
  State<DenouncePage> createState() => _DenouncePageState();
}

class _DenouncePageState extends State<DenouncePage> {
  final Api api = Api();
  final Uuid uuid = const Uuid();
  final ToastComponent toast = ToastComponent();
  final List<DenounceJustifyModel> _allDenounceJustify =
      DenounceJustifyModel.AllDenounceJustify;

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
        'idDenounce': currentOwner.value.first.id,
        'nickDenounced': currentOwner.value.first.nickname,
        'denounce': justifySelected
      };

      setState(() {
        //   api
        //       .setDenounce(_form)
        //       .then((result) => {
        //             // toast
        //             // Navigator.of(context).pushNamed("/home");
        //           })
        //       .catchError((error) {});
      });
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
