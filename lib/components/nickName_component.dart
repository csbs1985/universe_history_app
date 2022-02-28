// ignore_for_file: avoid_print, prefer_final_fields, unused_field, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/appbar_back_component.dart';
import 'package:universe_history_app/components/btn_component.dart';
import 'package:universe_history_app/components/pill_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class NickNameComponent extends StatefulWidget {
  const NickNameComponent({Key? key}) : super(key: key);

  @override
  State<NickNameComponent> createState() => _NickNameComponentState();
}

class _NickNameComponentState extends State<NickNameComponent> {
  final Api api = Api();
  final ToastComponent toast = ToastComponent();
  TextEditingController _textController = TextEditingController();

  bool _isInputNotEmpty = false;
  late String currentNickName = '';

  @override
  void initState() {
    if (currentUser.value.isNotEmpty) {
      _textController.text = currentUser.value.first.nickname;
    }
    super.initState();
  }

  _keyUp(String text) {
    if (currentNickName == _textController.text) {
      _isInputNotEmpty = false;
      return;
    }

    if (_textController.text.length > 4 && _textController.text.length > 20) {
      _isInputNotEmpty = false;
      return;
    }

    api
        .getNickName(_textController.text)
        .then((result) => {
              if (result.size > 0)
                {
                  setState(() {
                    _isInputNotEmpty = false;
                  })
                }
              else
                {_isInputNotEmpty = true}
            })
        .catchError((error) => print('ERROR: ' + error));
  }

  void _saveNickName() {
    currentUser.value.first.nickname = _textController.text;
    api
        .upNickName()
        .then(
          (result) => toast.toast(
              context, ToastEnum.SUCCESS, 'Nome de usuário alterado!'),
        )
        .catchError((error) => print('ERROR: ' + error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(
        btnBack: true,
        btnPublish: _isInputNotEmpty,
        callback: (value) => _saveNickName(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleResumeComponent('Nome de usuário',
                    'Escolha o nome que aparecerá em suas publicações, ele deve ser único e de 5 à 20 caracteres, diferenciamos letras maiusculas de minusculas. Veja também os caracteres especiais aceitos: & + @ # * - _ . :'),
                Container(
                  color: uiColor.comp_1,
                  child: TextField(
                    controller: _textController,
                    maxLines: 1,
                    maxLength: 20,
                    style: uiTextStyle.text1,
                    onChanged: (value) => _keyUp(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[a-zA-Z0-9&+$@#&*-_.:]+')),
                    ],
                    decoration: InputDecoration(
                      errorText: 'Nome não esta disponivél.',
                      counterStyle: const TextStyle(color: uiColor.comp_2),
                      hintText: 'usuário',
                      hintStyle: uiTextStyle.text7,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: uiColor.create_1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: _isInputNotEmpty
                                ? uiColor.success
                                : uiColor.warning),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
