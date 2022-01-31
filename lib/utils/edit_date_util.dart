import 'package:intl/intl.dart';

String editDateUtil(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var day = DateFormat('dd');
  var month = DateFormat('M');
  var year = DateFormat('yyyy');
  var time = '';
  var months = [
    'jan',
    'fev',
    'mar',
    'abr',
    'mai',
    'jun',
    'jul',
    'ago',
    'set',
    'out',
    'nov',
    'dez'
  ];

  if (diff.inMinutes < 60) {
    time = 'à ' + diff.inMinutes.floor().toString() + ' min';
  } else if (diff.inHours < 12) {
    time = 'à ' + diff.inHours.floor().toString() + ' horas';
  } else if (diff.inHours < 24) {
    time = 'hoje';
  } else if (diff.inHours < 48) {
    time = 'ontem';
  } else {
    time = day.format(date) +
        ' de ' +
        months[int.parse(month.format(date)) - 1] +
        '. de ' +
        year.format(date);
  }

  return time;
}
