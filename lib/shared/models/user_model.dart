// ignore_for_file: unnecessary_new, invalid_return_type_for_catch_error, avoid_print, unused_local_variable, avoid_returning_null_for_void

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/shared/enums/type_toast_enum.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/device_util.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);
ValueNotifier<String> currentNickname = ValueNotifier<String>('');
ValueNotifier<bool> userNew = ValueNotifier<bool>(false);

class UserModel {
  late String id;
  late String nickname;
  late String date;
  late String email;
  late String channel;
  late bool isDisabled;
  late bool isNotification;
  late num qtyHistory;
  late num qtyComment;

  UserModel({
    required this.id,
    required this.nickname,
    required this.date,
    required this.isDisabled,
    required this.email,
    required this.channel,
    required this.isNotification,
    required this.qtyHistory,
    required this.qtyComment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        nickname: json['nickname'],
        date: json["date"],
        email: json['email'],
        channel: json['channel'],
        isDisabled: json['isDisabled'],
        isNotification: json['isNotification'],
        qtyHistory: json['qtyHistory'],
        qtyComment: json['qtyComment'],
      );

  static String toJson(UserModel user) => jsonEncode(toMap(user));

  static Map<String, dynamic> toMap(UserModel user) => {
        'id': user.id,
        'nickname': user.nickname,
        'date': user.date,
        'email': user.email,
        'channel': user.channel,
        'isNotification': user.isNotification,
        'isDisabled': user.isDisabled,
        'qtyHistory': user.qtyHistory,
        'qtyComment': user.qtyComment,
      };
}

class UserClass {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ToastComponent toast = new ToastComponent();

  Future<void> clean(BuildContext context) async {
    await googleSignIn
        .signOut()
        .then((value) => {
              ActivityUtil(ActivitiesEnum.LOGOUT, DeviceModel(), ''),
              currentUser.value = [],
              deleteUser(),
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

  Future<FileSystemEntity> deleteUser() async {
    final file = await getFileUser();
    return file.delete();
  }

  void setFileUser(String file) {
    try {
      var json = jsonDecode(file);
      add(json);
    } catch (e) {
      print(e);
    }
  }
}
