import 'dart:convert';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<CommentModel>> currentComment =
    ValueNotifier<List<CommentModel>>([]);
ValueNotifier<num> currentQtyComment = ValueNotifier(0);

class CommentModel {
  CommentModel({
    required this.date,
    required this.historyId,
    required this.id,
    required this.isDelete,
    required this.isEdit,
    required this.isSigned,
    required this.text,
    required this.userId,
    required this.userName,
    required this.userStatus,
  });

  late String date;
  late String historyId;
  late String id;
  late bool isDelete;
  late bool isEdit;
  late bool isSigned;
  late String text;
  late String userId;
  late String userName;
  late String userStatus;

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
        userName: json['userName'],
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
        'userName': userName,
        'userStatus': userStatus
      };
}

class CommentClass {
  void setQtyComment(num qty) {
    currentQtyComment.value = qty;
  }

  void selectComment(CommentModel _comment) {
    currentComment.value = [];
    currentComment.value.add(_comment);
  }
}
