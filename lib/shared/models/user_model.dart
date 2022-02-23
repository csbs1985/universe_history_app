// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:flutter/cupertino.dart';

class UserModel {
  late final String id;
  final String nickname;
  final DateTime date;
  final String email;
  final String channel;
  final bool isDisabled;

  UserModel({
    required this.id,
    required this.nickname,
    required this.date,
    required this.isDisabled,
    required this.email,
    required this.channel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        nickname: json['nickname'],
        date: json['date'].toDate(),
        email: json['email'],
        channel: json['channel'],
        isDisabled: json['isDisabled'],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'id': id,
        'nickname': nickname,
        'date': date,
        'email': email,
        'channel': channel,
        'isDisabled': isDisabled,
      };
}

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);
