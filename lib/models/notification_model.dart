import 'dart:convert';

class NotificationModel {
  late String content;
  late String date;
  late String id;
  late String contentId;
  late String status;
  late String userId;
  late String userName;
  late bool view;

  NotificationModel({
    required this.content,
    required this.date,
    required this.id,
    required this.contentId,
    required this.status,
    required this.userId,
    required this.userName,
    required this.view,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel.fromMap(json);

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        content: json['content'],
        date: json['date'],
        id: json['id'],
        contentId: json['contentId'],
        status: json['status'],
        userId: json['userId'],
        userName: json['userName'],
        view: json['view'],
      );

  static String toJson(List<NotificationModel> notification) =>
      json.encode(toMap(notification));

  static Map<String, dynamic> toMap(notification) => {
        'content': notification['content'],
        'date': notification['date'],
        'id': notification['id'],
        'contentId': notification['contentId'],
        'status': notification['status'],
        'userId': notification['userId'],
        'userName': notification['userName'],
        'view': notification['view'],
      };
}
