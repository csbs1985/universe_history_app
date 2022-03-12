import 'package:universe_history_app/utils/edit_date_util.dart';

String resumeUitl(item) {
  var _date = editDateUtil(DateTime.parse(item['date']).millisecondsSinceEpoch);
  var author = item['isAnonymous'] ? 'anônimo' : item['userNickName'];
  var temp = _date + ' - ' + author;
  return item['isEdit'] ? temp + ' - editada' : temp;
}
