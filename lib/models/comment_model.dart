import 'dart:convert';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<CommentModel>> currentComment =
    ValueNotifier<List<CommentModel>>([]);
ValueNotifier<num> currentQtyComment = ValueNotifier(0);

class CommentModel {
  CommentModel({
    required this.id,
    required this.date,
    required this.historyId,
    required this.isSigned,
    required this.isEdit,
    required this.isDelete,
    required this.text,
    required this.userId,
    required this.userNickName,
    required this.userStatus,
  });

  late String id;
  late String date;
  late String historyId;
  late String text;
  late String userId;
  late String userNickName;
  late String userStatus;
  late bool isSigned;
  late bool isEdit;
  late bool isDelete;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      CommentModel.fromMap(json);

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        date: json['date'],
        historyId: json['historyId'],
        isSigned: json['isSigned'],
        isEdit: json['isEdit'],
        isDelete: json['isDelete'],
        text: json['text'],
        userId: json['userId'],
        userNickName: json['userNickName'],
        userStatus: json['userStatus'],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'historyId': historyId,
        'isSigned': isSigned,
        'isEdit': isEdit,
        'isDelete': isDelete,
        'text': text,
        'userId': userId,
        'userNickName': userNickName,
        'userStatus': userStatus
      };
}

class CommentClass {
  void setQtyComment(num qty) {
    currentQtyComment.value = qty;
  }

  void selectComment(Map<String, dynamic> _comment) {
    currentComment.value = [];
    currentComment.value.add(CommentModel.fromJson(_comment));
  }
}
