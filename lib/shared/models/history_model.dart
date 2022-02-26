// ignore_for_file: non_constant_identifier_names, unnecessary_new

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<String> currentHistory = ValueNotifier<String>('');
ValueNotifier<String> currentDocHistory = ValueNotifier<String>('');

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

  final String id;
  final String title;
  final String text;
  final DateTime date;
  final String userId;
  final String userNickName;
  final bool isComment;
  final bool isAnonymous;
  final bool isEdit;
  final int qtyComment;
  final List<String> categories;

  factory HistoryModel.fromJson(QueryDocumentSnapshot<dynamic> json) =>
      HistoryModel.fromMap(json);

  factory HistoryModel.fromMap(QueryDocumentSnapshot<dynamic> json) =>
      HistoryModel(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        date: json['date'].toDate(),
        isComment: json['isComment'],
        isAnonymous: json['isAnonymous'],
        isEdit: json['isEdit'],
        userId: json['userId'],
        userNickName: json['userNickName'],
        qtyComment: json['qtyComment'],
        categories: json['categories'],
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
  void selectHistory(String _history, String _doc) {
    currentHistory.value = _history;
    currentDocHistory.value = _doc;
  }
}
