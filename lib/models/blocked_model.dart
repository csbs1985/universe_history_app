import 'package:flutter/cupertino.dart';

ValueNotifier<List<BlockedModel>> currentBlockeds =
    ValueNotifier<List<BlockedModel>>([]);

class BlockedModel {
  late String blockerId;
  late String date;
  late String id;
  late String userId;
  late String userName;

  BlockedModel({
    required this.blockerId,
    required this.date,
    required this.id,
    required this.userId,
    required this.userName,
  });

  factory BlockedModel.fromJson(json) => BlockedModel.fromMap(json);

  factory BlockedModel.fromMap(json) => BlockedModel(
        blockerId: json['blockerId'],
        date: json['date'],
        id: json['id'],
        userId: json['userId'],
        userName: json['userName'],
      );
}

class BlockedClass {
  void add(Map<String, dynamic> _history) {
    currentBlockeds.value = [];
    currentBlockeds.value.add(BlockedModel.fromJson(_history));
  }
}
