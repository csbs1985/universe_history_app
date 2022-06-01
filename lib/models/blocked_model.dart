import 'package:flutter/cupertino.dart';

ValueNotifier<int> currentBlockedQty = ValueNotifier<int>(0);

class BlockedModel {
  final String userId;
  final String userName;
  final String date;

  BlockedModel({
    required this.userId,
    required this.userName,
    required this.date,
  });
}
