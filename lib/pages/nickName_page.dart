// ignore_for_file: avoid_print, prefer_final_fields, unused_field, prefer_is_empty, unrelated_type_equality_checks, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/push_notification.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:universe_history_app/utils/qty_days_util.dart';

class NickNamePage extends StatefulWidget {
  const NickNamePage({Key? key}) : super(key: key);

  @override
  State<NickNamePage> createState() => _NickNamePageState();
}

class _NickNamePageState extends State<NickNamePage> {
  final Api api = Api();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final PushNotification _notification = PushNotification();

  TextEditingController _textController = TextEditingController();

  bool _isInputNotEmpty = false;
  bool _hasInput = true;
  int _counter = 0;
  int _rulesDays = 30;
  String _textDefault = 'nome de usuário atual';
  String _oldName = '';
  String _regx = '[A-Za-z0-9-_.]';

  late String _message = _textDefault;

  @override
  void initState() {
    if (currentUser.value.isNotEmpty) {
      _oldName = currentUser.value.first.nickname;
      currentNickname.value = currentUser.value.first.nickname;
      _textController.text = currentUser.value.first.nickname;
      _counter = currentUser.value.first.nickname.length;
    }

    _keyUp(_oldName);
    _validateUpdateNickname();
    super.initState();
  }

  _validateUpdateNickname() {
    setState(() {
      var upDate = currentUser.value.first.upDateNickname;
      var _days = qtyDays(upDate);

      if (upDate != "" && _days < _rulesDays) {
        _hasInput = false;
        _isInputNotEmpty = false;
        _message =
            'espera mais ${_rulesDays - _days} dia(s) para alterar o usuário';
        return;
      }
    });
  }

  _keyUp(String text) {
    if (currentUser.value.isNotEmpty && _oldName == _textController.text) {
      setState(() {
        _isInputNotEmpty = false;
        _message = _textDefault;
      });
      return;
    }

    _counter = _textController.text.length;
    if (_counter < 6 || _counter > 20) {
      setState(() {
        _isInputNotEmpty = false;
        _message = 'nome de usuário não atende aos critérios';
      });
      return;
    }

    api
        .getNickName(_textController.text)
        .then((result) => {
              setState(() {
                if (result.size > 0) {
                  _isInputNotEmpty = false;
                  _message = 'nome de usuário indisponível';
                } else {
                  _isInputNotEmpty = true;
                  _message = 'nome de usuário disponível';
                }
              }),
            })
        .catchError((error) => print('ERROR: ' + error));
  }

  Future<void> _saveNickName() async {
    currentUser.value.first.nickname =
        currentNickname.value = _textController.text;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    userNew.value ? _newNickname() : _upNickname();

    _notification.getToken();
  }

  Future<void> _newNickname() async {
    await api
        .setUser(UserModel.toMap(currentUser.value.first))
        .then((result) => {
              ActivityUtil(
                  ActivitiesEnum.NEW_NICKNAME, _textController.text, ''),
              toast.toast(context, ToastEnum.SUCCESS, 'Conta criada!'),
              Navigator.of(context).pushNamed('/home')
            })
        .catchError((error) => print('ERROR:' + error.toString()));
  }

  Future<void> _upNickname() async {
    var _now = DateTime.now().toString();

    await api
        .upNickName(_now)
        .then((result) => {
              currentUser.value.first.upDateNickname = _now,
              _upAllHistory(),
            })
        .catchError((error) => print('ERROR:' + error.toString()));
  }

  Future<void> _upAllHistory() async {
    await api
        .getAllUserHistory()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api
                      .upNicknameHistory(item['id'])
                      .then((result) => {_upAllComment()})
            })
        .catchError((error) => print('ERROR:' + error.toString()));
  }

  Future<void> _upAllComment() async {
    await api
        .getAllUserComment()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.upNicknameComment(item['id']).then((result) => {
                        ActivityUtil(ActivitiesEnum.UP_NICKNAME,
                            _textController.text, _oldName),
                        toast.toast(context, ToastEnum.SUCCESS,
                            'Nome de usuário alterado!'),
                        Navigator.of(context).pop()
                      })
            })
        .catchError((error) => print('ERROR:' + error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(
          btnBack: true,
          btnPublish: _isInputNotEmpty,
          callback: (value) => _saveNickName()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleResumeComponent('Nome de usuário',
                    'Os nomes de usuário só podem usar letras, números, sublinhados e pontos. Ele deve ser único e de 6 à 20 caracteres. Você só poderá altera a cada 30 dias.'),
                const SizedBox(height: 10),
                Container(
                  color: uiColor.comp_1,
                  child: TextField(
                    controller: _textController,
                    maxLines: 1,
                    maxLength: 20,
                    style: uiTextStyle.text1,
                    onChanged: (value) => _keyUp(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(_regx))
                    ],
                    decoration: InputDecoration(
                      enabled: _hasInput,
                      hintText: 'Nome de usuário',
                      fillColor: _hasInput ? uiColor.comp_1 : uiColor.comp_3,
                      filled: true,
                      hintStyle: uiTextStyle.text7,
                      counterStyle: const TextStyle(fontSize: 0),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(uiBorder.rounded),
                        borderSide:
                            const BorderSide(width: 1, color: uiColor.warning),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(uiBorder.rounded),
                        borderSide: BorderSide(
                          width: 1,
                          color: _isInputNotEmpty
                              ? uiColor.success
                              : uiColor.warning,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(uiBorder.rounded),
                        borderSide: BorderSide(
                          width: 1,
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
                    Text(_message, style: uiTextStyle.text2),
                    Text(_counter.toString() + '/20', style: uiTextStyle.text2)
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
