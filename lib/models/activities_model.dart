import 'dart:convert';

class ActivitiesModel {
  late String id;
  late String date;
  late String userId;
  late String type;
  late String elementId;
  late String content;

  ActivitiesModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.type,
    required this.elementId,
    required this.content,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) =>
      ActivitiesModel.fromMap(json);

  factory ActivitiesModel.fromMap(Map<String, dynamic> json) => ActivitiesModel(
        id: json['id'],
        userId: json['userId'],
        date: json['date'],
        type: json['type'],
        elementId: json['elementId'],
        content: json['content'],
      );

  static String toJson(ActivitiesModel activity) => jsonEncode(toMap(activity));

  static Map<String, dynamic> toMap(activity) => {
        'id': activity['id'],
        'userId': activity['userId'],
        'date': activity['date'],
        'type': activity['type'],
        'elementId': activity['elementId'],
        'content': activity['content'],
      };
}
