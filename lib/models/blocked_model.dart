// ignore_for_file: unnecessary_new

import 'package:flutter/cupertino.dart';

ValueNotifier<int> currentBlockedQty = ValueNotifier<int>(0);

class BlockedModel {
  final String userId;
  final String userNickName;
  final String date;

  BlockedModel({
    required this.userId,
    required this.userNickName,
    required this.date,
  });
}
