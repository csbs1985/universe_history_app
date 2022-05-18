// ignore_for_file: constant_identifier_names, unrelated_type_equality_checks

import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

String resumeUitl(_item, {String? type}) {
  String? _userStatus;
  String? _date;
  String? _userNickName;
  bool? _isEdit;
  bool? _isSigned;

  if (_item is CommentModel) {
    _date = _item.date;
    _isEdit = _item.isEdit;
    _isSigned = _item.isSigned;
    _userNickName = _item.userNickName;
  } else {
    _date = _item['date'];
    _isEdit = _item['isEdit'];
    _isSigned = _item['isSigned'];
    _userNickName = _item['userNickName'];
  }

  var _time = editDateUtil(_date!);
  var author = '';

  if (type == ContentType.COMMENT.toString().split('.').last) {
    _userStatus =
        _item is CommentModel ? _item.userStatus : _item['userStatus'];

    _userStatus == UserStatus.DELETED.toString().split('.').last
        ? author = 'usuário deletado'
        : author = _isSigned! ? _userNickName! : 'anônimo';
  }

  var temp = _time + ' · ' + author;
  return _isEdit! ? temp + ' · editado' : temp;
}

enum ContentType { COMMENT, HISTORY }
