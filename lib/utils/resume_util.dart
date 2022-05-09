// ignore_for_file: constant_identifier_names, unrelated_type_equality_checks

import 'package:universe_history_app/shared/models/user_model.dart';
import 'package:universe_history_app/utils/edit_date_util.dart';

String resumeUitl(_item, {String? type}) {
  var _date =
      editDateUtil(DateTime.parse(_item['date']).millisecondsSinceEpoch);
  var author = '';

  type == ContentType.COMMENT.toString().split('.').last &&
          _item['userStatus'] == UserStatus.DELETED.toString().split('.').last
      ? author = 'usuário deletado'
      : author = _item['isSigned'] ? _item['userNickName'] : 'anônimo';

  var temp = _date + ' · ' + author;
  return _item['isEdit'] ? temp + ' · editado' : temp;
}

enum ContentType { COMMENT, HISTORY }
