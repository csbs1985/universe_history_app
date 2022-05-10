// ignore_for_file: unnecessary_new

import 'dart:convert';

class NotificationModel {
  late String content;
  late String date;
  late String id;
  late String idContent;
  late String idUser;
  late String nickName;
  late String status;
  late bool view;

  NotificationModel({
    required this.content,
    required this.date,
    required this.id,
    required this.idContent,
    required this.idUser,
    required this.nickName,
    required this.status,
    required this.view,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel.fromMap(json);

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        content: json['content'],
        date: json['date'],
        id: json['id'],
        idContent: json['idContent'],
        idUser: json['idUser'],
        nickName: json['nickName'],
        status: json['status'],
        view: json['view'],
      );

  static String toJson(List<NotificationModel> category) =>
      json.encode(toMap(category));

  static Map<String, dynamic> toMap(List<NotificationModel> category) => {
        'content': category.first.content,
        'date': category.first.date,
        'id': category.first.id,
        'idContent': category.first.idContent,
        'idUser': category.first.idUser,
        'nickName': category.first.nickName,
        'status': category.first.status,
        'view': category.first.view,
      };
}
