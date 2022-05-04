int qtyDays(String _upDateNickname) {
  var _date = DateTime.fromMillisecondsSinceEpoch(
      DateTime.parse(_upDateNickname).millisecondsSinceEpoch);
  var _now = DateTime.now();
  var _diff = _now.difference(_date);

  return _diff.inDays;
}
