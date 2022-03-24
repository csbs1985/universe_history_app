// ignore_for_file: avoid_print, prefer_final_fields, unused_field, prefer_is_empty, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class NickNamePage extends StatefulWidget {
  const NickNamePage({Key? key}) : super(key: key);

  @override
  State<NickNamePage> createState() => _NickNamePageState();
}

class _NickNamePageState extends State<NickNamePage> {
  final Api api = Api();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  TextEditingController _textController = TextEditingController();

  bool _isInputNotEmpty = false;
  String _message = 'nome de usuário atual.';
  int _counter = 0;

  @override
  void initState() {
    if (currentUser.value.isNotEmpty) {
      currentNickname.value = currentUser.value.first.nickname;
      _textController.text = currentUser.value.first.nickname;
      _counter = currentUser.value.first.nickname.length;
    }
    super.initState();
  }

  _keyUp(String text) {
    setState(() {
      _counter = _textController.text.length;

      if (currentUser.value.isNotEmpty &&
          currentNickname.value == _textController.text) {
        _isInputNotEmpty = false;
        _message = 'nome de usuário atual.';
        return;
      }

      if (_textController.text.length < 5 || _textController.text.length > 20) {
        _isInputNotEmpty = false;
        _message = 'nome de usuário não atende aos critérios.';
        return;
      }

      api
          .getNickName(_textController.text)
          .then((result) => {
                if (result.size > 0)
                  {
                    _isInputNotEmpty = false,
                    _message = 'nome de usuário não disponível.',
                  }
                else
                  {
                    _isInputNotEmpty = true,
                    _message = 'nome de usuário disponível.'
                  }
              })
          .catchError((error) => print('ERROR: ' + error));
    });
  }

  Future<void> _saveNickName() async {
    currentNickname.value = _textController.text;
    currentUser.value.first.nickname = _textController.text;

    if (userNew.value) {
      api.setUser(UserModel.toMap(currentUser.value.first));
      ActivityUtil(ActivitiesEnum.NEW_NICKNAME, _textController.text, '');
      toast.toast(context, ToastEnum.SUCCESS, 'Conta criada!');
      Navigator.of(context).pushNamed('/home');
    } else {
      try {
        await api.upNickName();
        ActivityUtil(ActivitiesEnum.UP_NICKNAME, _textController.text, '');
        toast.toast(context, ToastEnum.SUCCESS, 'Nome de usuário alterado!');
        Navigator.of(context).pop();
      } catch (error) {
        print('ERROR: ' + error.toString());
      }
    }
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleResumeComponent('Nome de usuário',
                    'Escolha o nome que aparecerá em suas publicações, ele deve ser único e de 5 à 20 caracteres, diferenciamos letras maiusculas de minusculas. Veja pode usar também espaço em branco e estes caracteres especiais: & + / * - _ . :'),
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
                          RegExp('[A-Za-z0-9- & + / * - _ . :]+')),
                    ],
                    decoration: InputDecoration(
                      hintText: 'usuário',
                      hintStyle: uiTextStyle.text7,
                      counterStyle: const TextStyle(color: uiColor.comp_1),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _isInputNotEmpty
                              ? uiColor.success
                              : uiColor.warning,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _isInputNotEmpty
                              ? uiColor.success
                              : uiColor.warning,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _message,
                      style: uiTextStyle.text2,
                    ),
                    Text(
                      _counter.toString() + '/20',
                      style: uiTextStyle.text2,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
