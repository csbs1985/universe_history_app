// ignore_for_file: unnecessary_new, invalid_return_type_for_catch_error, avoid_print

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);

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

class UserClass {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ToastComponent toast = new ToastComponent();

  Future<void> clean(BuildContext context) async {
    await googleSignIn
        .signOut()
        .then((value) => {
              currentUser.value = [],
              Navigator.of(context).pushNamed("/home"),
            })
        .catchError((error) {
      print('ERROR: ' + error.toString());
      toast.toast(context, ToastEnum.WARNING,
          'ERROR: não foi possivél sair da aplicação no momento, tente novamente mais tarde.');
    });
  }

  void add(Map<String, dynamic> _user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(_user));
  }
}
