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
    required this.isAuthorized,
    required this.userId,
    required this.userName,
    required this.qtyComment,
    required this.categories,
    required this.bookmarks,
  });

  late String id;
  late String title;
  late String text;
  late String date;
  late String userId;
  late String userName;
  late bool isComment;
  late bool isSigned;
  late bool isEdit;
  late bool isAuthorized;
  late int qtyComment;
  late List<String> categories;
  late List<String> bookmarks;

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
        isAuthorized: json['isAuthorized'],
        userId: json['userId'],
        userName: json['userName'],
        qtyComment: json['qtyComment'],
        categories: json['categories'].cast<String>(),
        bookmarks: json['bookmarks'].cast<String>(),
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
        'isAuthorized': isAuthorized,
        'userId': userId,
        'userName': userName,
        'qtyComment': qtyComment,
        'categories': categories,
        'bookmarks': bookmarks,
      };
}

class HistoryClass {
  void add(Map<String, dynamic> _history) {
    currentHistory.value = [];
    currentHistory.value.add(HistoryModel.fromJson(_history));
  }

  void selectHistory(_history) {
    currentHistory.value = [];
    currentHistory.value.add(_history);
  }
}
