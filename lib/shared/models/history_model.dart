// ignore_for_file: non_constant_identifier_names, unnecessary_new

import 'dart:convert';

class HistoryModel {
  HistoryModel({
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

  factory HistoryModel.fromJson(String str) =>
      HistoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        title: json['title'],
        text: json['text'],
        date: json['date'],
        isComment: json['isComment'],
        isAnonymous: json['isAnonymous'],
        isEdit: json['isEdit'],
        userId: json['userId'],
        userNickName: json['userNickName'],
        qtyComment: json['qtyComment'],
        categories: json['categories'],
      );

  Map<String, dynamic> toMap() => {
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

  static Set<HistoryModel> history = {
    new HistoryModel(
      title: 'title',
      text: 'text',
      date: DateTime.now(),
      isComment: false,
      isAnonymous: false,
      isEdit: false,
      userId: 'userId',
      userNickName: 'userNickName',
      qtyComment: 0,
      categories: [],
    ),
  };
}
