// ignore_for_file: unnecessary_new, invalid_return_type_for_catch_error, avoid_print, unused_local_variable, avoid_returning_null_for_void, constant_identifier_names, unused_element, await_only_futures

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/device_util.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);
ValueNotifier<String> currentNickname = ValueNotifier<String>('');
ValueNotifier<bool> userNew = ValueNotifier<bool>(false);

class UserModel {
  late String id;
  late String nickname;
  late String upDateNickname;
  late String date;
  late String email;
  late String channel;
  late String token;
  late String status;
  late bool isNotification;
  late num qtyHistory;
  late num qtyComment;

  UserModel({
    required this.id,
    required this.nickname,
    required this.upDateNickname,
    required this.date,
    required this.status,
    required this.email,
    required this.channel,
    required this.token,
    required this.isNotification,
    required this.qtyHistory,
    required this.qtyComment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        nickname: json['nickname'],
        upDateNickname: json['upDateNickname'],
        date: json["date"],
        email: json['email'],
        channel: json['channel'],
        token: json['token'],
        status: json['status'],
        isNotification: json['isNotification'],
        qtyHistory: json['qtyHistory'],
        qtyComment: json['qtyComment'],
      );

  static String toJson(UserModel user) => jsonEncode(toMap(user));

  static Map<String, dynamic> toMap(UserModel user) => {
        'id': user.id,
        'nickname': user.nickname,
        'upDateNickname': user.upDateNickname,
        'date': user.date,
        'email': user.email,
        'channel': user.channel,
        'token': user.token,
        'isNotification': user.isNotification,
        'status': user.status,
        'qtyHistory': user.qtyHistory,
        'qtyComment': user.qtyComment,
      };
}

class UserClass {
  final Api api = Api();
  final AuthService authService = AuthService();
  final ToastComponent toast = ToastComponent();

  Future<void> clean(BuildContext context, String _status) async {
    try {
      await authService.logout();
      ActivityUtil(ActivitiesEnum.LOGOUT, DeviceModel(), '');
      currentUser.value = [];
      toast.toast(
          context, ToastEnum.SUCCESS, 'espero que isso não seja um adeus!');
    } catch (e) {
      toast.toast(context, ToastEnum.WARNING,
          'não foi possível sair da aplicação no momento, tente novamente mais tarde.');
    }
  }

  Future<void> delete(BuildContext context) async {
    await api
        .deleteUser(currentUser.value.first.id)
        .then((result) async => {
              await authService.delete(),
              currentUser.value = [],
            })
        .catchError((error) {
      Navigator.of(context).pop();
      debugPrint('ERROR:' + error.toString());
      toast.toast(context, ToastEnum.WARNING,
          'não foi possível delatar a conta no momento, tente novamente mais tarde.');
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
      add(json);
    } catch (e) {
      print(e);
    }
  }

  UserStatus getUserStatus(String _status) {
    switch (_status) {
      case 'INACTIVE':
        return UserStatus.INACTIVE;
      case 'DISABLED':
        return UserStatus.DISABLED;
      case 'DELETED':
        return UserStatus.DELETED;
      case 'ACTIVE':
      default:
        return UserStatus.ACTIVE;
    }
  }
}

enum UserStatus { ACTIVE, INACTIVE, DISABLED, DELETED }
