// ignore_for_file: unnecessary_new

import 'dart:convert';

class ActivitiesModel {
  late String id;
  late String date;
  late String idUser;
  late String type;
  late String elementId;
  late String content;
  late String? complement;

  ActivitiesModel({
    required this.id,
    required this.idUser,
    required this.date,
    required this.type,
    required this.elementId,
    required this.content,
    this.complement,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesModel.fromMap(json);

  factory ActivitiesModel.fromMap(Map<String, dynamic> json) => ActivitiesModel(
        id: json['id'],
        idUser: json['idUser'],
        date: json['date'],
        type: json['type'],
        elementId: json['elementId'],
        content: json['content'],
        complement: json['complement'],
      );

  static String toJson(List<ActivitiesModel> category) =>
      json.encode(toMap(category));

  static Map<String, dynamic> toMap(List<ActivitiesModel> category) => {
        'id': category.first.id,
        'idUser': category.first.idUser,
        'date': category.first.date,
        'type': category.first.type,
        'elementId': category.first.elementId,
        'content': category.first.content,
        'complement': category.first.complement!,
      };
}
