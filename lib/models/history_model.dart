import 'dart:convert';
import 'package:flutter/cupertino.dart';

ValueNotifier<List<HistoryModel>> currentHistory =
    ValueNotifier<List<HistoryModel>>([]);

class HistoryModel {
  HistoryModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.isComment,
    required this.isSigned,
    required this.isEdit,
    required this.isDelete,
    required this.isAuthorized,
    required this.userId,
    required this.userNickName,
    required this.qtyComment,
    required this.categories,
  });

  late String id;
  late String title;
  late String text;
  late String date;
  late String userId;
  late String userNickName;
  late bool isComment;
  late bool isSigned;
  late bool isEdit;
  late bool isDelete;
  late bool isAuthorized;
  late int qtyComment;
  late List<String> categories;

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      HistoryModel.fromMap(json);

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        date: json['date'],
        isComment: json['isComment'],
        isSigned: json['isSigned'],
        isEdit: json['isEdit'],
        isDelete: json['isDelete'],
        isAuthorized: json['isAuthorized'],
        userId: json['userId'],
        userNickName: json['userNickName'],
        qtyComment: json['qtyComment'],
        categories: json['categories'].cast<String>(),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'text': text,
        'date': date,
        'isComment': isComment,
        'isSigned': isSigned,
        'isEdit': isEdit,
        'isDelete': isDelete,
        'isAuthorized': isAuthorized,
        'userId': userId,
        'userNickName': userNickName,
        'qtyComment': qtyComment,
        'categories': categories,
      };
}

class HistoryClass {
  void selectHistory(Map<String, dynamic> _history) {
    currentHistory.value = [];
    currentHistory.value.add(HistoryModel.fromJson(_history));
  }
}
