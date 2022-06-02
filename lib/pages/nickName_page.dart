import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe_history_app/components/appBar_component.dart';
import 'package:universe_history_app/components/loader_component.dart';
import 'package:universe_history_app/components/title_resume_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/user_model.dart';
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
  final TextEditingController _textController = TextEditingController();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();

  bool _isInputNotEmpty = false;
  bool _hasInput = true;
  int _counter = 0;
  String _oldName = '';

  final int _rulesDays = 30;
  final String _textDefault = 'nome de usuário atual';
  final String _regx = '[a-z0-9-_.]';

  late String _message = _textDefault;

  @override
  void initState() {
    super.initState();

    if (currentUser.value.isNotEmpty) {
      _oldName = currentUser.value.first.name;
      currentNickname.value = currentUser.value.first.name;
      _textController.text = currentUser.value.first.name;
      _counter = currentUser.value.first.name.length;
    }

    _validateupDateName();
    _keyUp(_oldName);
  }

  _validateupDateName() {
    api.getUser(currentUser.value.first.email).then((result) {
      setState(() {
        var _days = qtyDays(result.docs.first['upDateName']);

        if (_days < _rulesDays) {
          _hasInput = false;
          _isInputNotEmpty = false;
          _message =
              'espere mais ${_rulesDays - _days} dia(s) para alterar o usuário';
          return;
        }
      });
    }).catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  _keyUp(String text) {
    RegExp regExp = RegExp(_regx);

    if (!regExp.hasMatch(_textController.text)) {
      setState(() {
        _isInputNotEmpty = false;
        _message = "veja a cima os caracteres aceitos";
      });
      return;
    }

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
        .catchError((error) => debugPrint('ERROR: ' + error));
  }

  Future<void> _saveNickName() async {
    currentDialog.value = 'Iniciando...';
    currentUser.value.first.name = currentNickname.value = _textController.text;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderComponent();
        });

    _upNickname();
  }

  Future<void> _upNickname() async {
    currentUser.value.first.name = _textController.text;
    currentUser.value.first.upDateName = DateTime.now().toString();
    currentDialog.value = 'Alterando nome de usuário...';

    await api
        .upNickName()
        .then((result) => {
              _upAllHistory(),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  Future<void> _upAllHistory() async {
    currentDialog.value = 'Alterando nome de usuário nas histórias...';

    await api
        .getAllUserHistory()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.upNicknameHistory(item['id']),
              _upAllComment()
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  Future<void> _upAllComment() async {
    currentDialog.value = 'Alterando nome de usuário nos comentários...';

    await api
        .getAllUserComment()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await api.upNicknameComment(item['id']),
              ActivityUtil(ActivitiesEnum.UP_NICKNAME.name,
                  _textController.text, _oldName),
              toast.toast(
                  context, ToastEnum.SUCCESS.name, 'Nome de usuário alterado!'),
              currentDialog.value = 'Finalizando...',
              Navigator.of(context).pushNamed('/home')
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
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
                    'Os nomes de usuário só podem usar letras, números, sublinhados e pontos, deve ser único e de 6 à 20 caracteres. Você só poderá altera a cada 30 dias.'),
                const SizedBox(height: 10),
                Container(
                  color: UiColor.comp_1,
                  child: TextField(
                    controller: _textController,
                    maxLines: 1,
                    maxLength: 20,
                    autofocus: true,
                    style: UiTextStyle.text1,
                    onChanged: (value) => _keyUp(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(_regx))
                    ],
                    decoration: InputDecoration(
                      enabled: _hasInput,
                      hintText: 'Nome de usuário',
                      fillColor: _hasInput ? UiColor.comp_1 : UiColor.comp_3,
                      filled: true,
                      hintStyle: UiTextStyle.text7,
                      counterStyle: const TextStyle(fontSize: 0),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                        borderSide:
                            const BorderSide(width: 1, color: UiColor.warning),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                        borderSide: BorderSide(
                            width: 1,
                            color: _isInputNotEmpty
                                ? UiColor.success
                                : UiColor.warning),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(UiBorder.rounded),
                        borderSide: BorderSide(
                          width: 1,
                          color: _isInputNotEmpty
                              ? UiColor.success
                              : UiColor.warning,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_message, style: UiTextStyle.text2),
                    Text(
                      _counter.toString() + '/20',
                      style: UiTextStyle.text2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
