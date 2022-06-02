import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/components/button_publish_component.dart';
import 'package:universe_history_app/components/divider_component.dart';
import 'package:universe_history_app/components/icon_component.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/components/toggle_component.dart';
import 'package:universe_history_app/modal/mentioned_modal.dart';
import 'package:universe_history_app/pages/notification_page.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/services/push_notification_service.dart';
import 'package:universe_history_app/services/realtime_database_service.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_svg.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';
import 'package:uuid/uuid.dart';

class InputCommmentModal extends StatefulWidget {
  const InputCommmentModal({String? id}) : _id = id;

  final String? _id;

  @override
  _InputCommmentModalState createState() => _InputCommmentModalState();
}

class _InputCommmentModalState extends State<InputCommmentModal> {
  final RealtimeDatabaseService db = RealtimeDatabaseService();
  final TextEditingController _commentController = TextEditingController();
  final ToastComponent toast = ToastComponent();
  final UserClass userClass = UserClass();
  final Api api = Api();
  final Uuid uuid = const Uuid();

  late Map<String, dynamic> _form;

  Map<String, dynamic>? _commentEdit;

  bool _isEdit = false;
  bool _isInputNotEmpty = false;
  bool _textSigned = true;

  List<String> idMencioned = [];

  @override
  void initState() {
    // edit
    if (widget._id != null) {
      _isEdit = true;
      api
          .getComment(widget._id!)
          .then((result) => {
                _commentController.text = result.docs[0].data()['text'],
                _isInputNotEmpty = true,
                _textSigned = result.docs[0].data()['isSigned'],
                _commentEdit = result.docs[0].data(),
                _commentEdit?['edit'] = true
              })
          .catchError((error) => debugPrint('ERROR:' + error.toString()));
    }

    super.initState();
  }

  void keyUp(String _text) {
    if (_text.isNotEmpty) {
      var lastString = _text.substring(_text.length - 1, _text.length);

      if ((_text.length <= 1 && _text.contains('@')) ||
          (_text.length > 1 && lastString == '@'))
        _showMentioned(context, MentionedCallEnum.KEYBOARD);
    }

    setState(() =>
        _isInputNotEmpty = _commentController.text.isNotEmpty ? true : false);
  }

  _toggleAnonimous() => setState(() => _textSigned = !_textSigned);

  void _showMentioned(BuildContext context, MentionedCallEnum type) {
    showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: Colors.black87,
        duration: const Duration(milliseconds: 300),
        builder: (context) =>
            MentionedModal(callback: (value) => _setText(value, type)));
  }

  void _setText(_user, MentionedCallEnum type) {
    setState(() {
      _isInputNotEmpty = true;
      var _id = _user['objectID'];

      idMencioned.contains(_id) ? null : idMencioned.add(_id);

      if (type == MentionedCallEnum.ICON)
        _commentController.text =
            _commentController.text + '@' + _user['name'] + ' ';

      if (type == MentionedCallEnum.KEYBOARD) {
        var value = _commentController.text
            .substring(0, _commentController.text.length - 1);

        _commentController.text = value + '@' + _user['name'] + ' ';
      }
    });
  }

  ///// publicar notificação

  Future<void> _postNewComment() async {
    setState(() {
      _form = {
        'date': _commentEdit?['date'] ?? DateTime.now().toString(),
        'historyId':
            _commentEdit?['historyId'] ?? currentHistory.value.first.id,
        'id': _commentEdit?['id'] ?? uuid.v4(),
        'isDelete': false,
        'isEdit': _commentEdit?['edit'] ?? false,
        'isSigned': _textSigned,
        'text': _commentController.text.trim(),
        'userId': _commentEdit?['userId'] ?? currentUser.value.first.id,
        'userName': _commentEdit?['userName'] ?? currentUser.value.first.name,
        'userStatus': currentUser.value.first.status
      };
    });

    try {
      await db.postNewComment(_form);
      _pathQtyCommentHistory();
    } on AuthException catch (error) {
      debugPrint('ERROR => postNewComment: ' + error.toString());
    }
  }

  Future<void> _pathQtyCommentHistory() async {
    if (!_isEdit) currentHistory.value.first.qtyComment++;

    try {
      await db.pathQtyCommentHistory(currentHistory.value.first);
      ActivityUtil(
        ActivitiesEnum.NEW_COMMENT.name,
        _commentController.text,
        currentHistory.value.first.id,
      );
      _pathQtyCommentUser();
    } on AuthException catch (error) {
      debugPrint('ERROR => pathQtyCommentHistory: ' + error.toString());
    }
  }

  Future<void> _pathQtyCommentUser() async {
    if (!_isEdit) currentUser.value.first.qtyComment++;

    try {
      await db.pathQtyCommentUser(currentUser.value.first);
      if (currentUser.value.first.id != currentHistory.value.first.userId) {
        _postNewNotification();
      }
      if (idMencioned.isNotEmpty) _setNotificationMencioned();
      if (_isEdit) Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.SUCCESS.name,
        _isEdit
            ? 'Seu comentário foi alterado.'
            : 'Seu comentário foi publicado.',
      );
      Navigator.of(context).pop();
    } on AuthException catch (error) {
      debugPrint('ERROR => pathQtyCommentUser: ' + error.toString());
    }
  }

  Future<void> _postNewNotification() async {
    _form = {
      'id': uuid.v4(),
      'idUser': currentHistory.value.first.userId,
      'nickName': _textSigned ? currentUser.value.first.name : 'anônimo',
      'view': false,
      'idContent': currentHistory.value.first.id,
      'content': currentHistory.value.first.title,
      'date': DateTime.now().toString(),
      'status': _textSigned
          ? NotificationEnum.COMMENT_SIGNED.toString()
          : NotificationEnum.COMMENT_ANONYMOUS.toString()
    };

    try {
      await db.postNewNotification(_form);
      _setPushNotificationOnwer(currentHistory.value.first.userId);
    } on AuthException catch (error) {
      debugPrint('ERROR => postNewNotification: ' + error.toString());
    }
  }

  void _setPushNotificationOnwer(String _user) {
    var history = currentHistory.value.first;
    var title = '';
    var body = '';

    title = _textSigned
        ? (currentUser.value.first.name +
            ' fez um comentário na história "' +
            history.title +
            '"')
        : ('Sua história "' +
            history.title +
            '" recebeu um comentário anônimo.');

    body = _textSigned
        ? currentUser.value.first.name +
            ': "' +
            _commentController.text.trim() +
            '"'
        : '"' + _commentController.text.trim() + '"';

    _sendNotification(title, body, _user);
  }

  Future<void> _setNotificationMencioned() async {
    for (var item in idMencioned) {
      if (currentUser.value.first.id != item) {
        _form = {
          'id': uuid.v4(),
          'idUser': item,
          'nickName': _textSigned ? currentUser.value.first.name : 'anônimo',
          'view': false,
          'idContent': currentHistory.value.first.id,
          'content': currentHistory.value.first.title,
          'date': DateTime.now().toString(),
          'status': NotificationEnum.COMMENT_MENTIONED.toString()
        };

        try {
          db.postNewNotification(_form);
          _setPushNotificationMentioned(item);
        } on AuthException catch (error) {
          debugPrint('ERROR => postNewNotification: ' + error.toString());
        }
      }
    }
  }

  void _setPushNotificationMentioned(String _user) {
    var history = currentHistory.value.first;
    var title = '';
    var body = '';

    title = currentUser.value.first.name +
        ' mencionou você em um comentário da história "' +
        history.title +
        '".';

    body = _textSigned
        ? currentUser.value.first.name +
            ': "' +
            _commentController.text.trim() +
            '"'
        : '"' + _commentController.text.trim() + '"';

    _sendNotification(title, body, _user);
  }

  Future<void> _sendNotification(
    String _title,
    String _body,
    String _user,
  ) async {
    await Provider.of<PushNotificationService>(context, listen: false)
        .sendNotification(
      _title,
      _body,
      currentHistory.value.first.id,
      _user,
    );
  }

  void _clean() {
    if (_commentController.text.isEmpty)
      Navigator.of(context).pop();
    else
      setState(() {
        _commentController.clear();
        _isInputNotEmpty = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: UiColor.comp_1,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom + UiSize.input),
              child: SingleChildScrollView(
                child: TextField(
                  controller: _commentController,
                  onChanged: (value) => keyUp(value),
                  autofocus: true,
                  minLines: 1,
                  maxLines: null,
                  style: UiTextStyle.text1,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: UiColor.comp_1, width: 0)),
                    hintText:
                        "Escreva aqui seu comentário, ele pode ajudar alguém em um momento difícil, escolha com cuidado suas palavras.",
                    hintStyle: UiTextStyle.text7,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const DividerComponent(bottom: 0),
                Container(
                  color: UiColor.comp_1,
                  height: UiSize.input,
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconComponent(
                            icon: UiSvg.clean,
                            callback: (value) => _clean(),
                          ),
                          IconComponent(
                            icon: UiSvg.mentioned,
                            callback: (value) =>
                                _showMentioned(context, MentionedCallEnum.ICON),
                          ),
                          const SizedBox(width: 10),
                          ToggleComponent(
                            value: _textSigned,
                            callback: (value) => _toggleAnonimous(),
                          ),
                          const SizedBox(width: 10),
                          Text(
                              _textSigned
                                  ? currentUser.value.first.name
                                  : 'anônimo',
                              style: UiTextStyle.text2)
                        ],
                      ),
                      if (_isInputNotEmpty)
                        ButtonPublishComponent(
                          callback: (value) => _postNewComment(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
