// ignore_for_file: unnecessary_new, invalid_return_type_for_catch_error, avoid_print, unused_local_variable, avoid_returning_null_for_void

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
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
        date: DateTime.parse(json["date"]),
        email: json['email'],
        channel: json['channel'],
        isDisabled: json['isDisabled'],
      );

  static String toJson(UserModel user) => jsonEncode(toMap(user));

  static Map<String, dynamic> toMap(UserModel user) => {
        'id': user.id,
        'nickname': user.nickname,
        'date': user.date.toString(),
        'email': user.email,
        'channel': user.channel,
        'isDisabled': user.isDisabled,
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
    saveUser();
  }

  Future<File> getFileUser() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user.json');
  }

  Future<File> saveUser() async {
    String data = UserModel.toJson(currentUser.value.first);
    final file = await getFileUser();
    return file.writeAsString(data);
  }

  Future<String> readUser() async {
    final file = await getFileUser();
    return file.readAsString();
  }

  void setFileUser(String file) {
    try {
      var json = jsonDecode(file);
      var user = UserModel.fromJson(json);
      currentUser.value = [];
      currentUser.value.add(user);
    } catch (e) {
      print(e);
    }
  }
}
