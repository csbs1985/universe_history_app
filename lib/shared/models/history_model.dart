// ignore_for_file: non_constant_identifier_names, unnecessary_new

import 'dart:convert';
import 'package:flutter/cupertino.dart';

ValueNotifier<int> currentQtyHistory = ValueNotifier<int>(0);
ValueNotifier<String> currentDocHistory = ValueNotifier<String>('');
ValueNotifier<List<HistoryModel>> currentHistory =
    ValueNotifier<List<HistoryModel>>([]);

class HistoryModel {
  HistoryModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.isComment,
    required this.isAnonymous,
    required this.isEdit,
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
  late bool isAnonymous;
  late bool isEdit;
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
        isAnonymous: json['isAnonymous'],
        isEdit: json['isEdit'],
        userId: json['userId'],
        userNickName: json['userNickName'],
        qtyComment: json['qtyComment'],
        categories: [],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'text': text,
        'date': date,
        'isComment': isComment,
        'isAnonymous': isAnonymous,
        'isEdit': isEdit,
        'userId': userId,
        'userNickName': userNickName,
        'qtyComment': qtyComment,
        'categories': categories,
      };
}

class HistoryClass {
  static void selectHistory(Map<String, dynamic> _history) {
    currentHistory.value = [];
    currentHistory.value.add(HistoryModel.fromJson(_history));
  }
}
