import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universe_history_app/components/toast_component.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/services/auth_service.dart';
import 'package:universe_history_app/utils/activity_util.dart';
import 'package:universe_history_app/utils/device_util.dart';

ValueNotifier<List<UserModel>> currentUser = ValueNotifier<List<UserModel>>([]);
ValueNotifier<String> currentNickname = ValueNotifier<String>('');
ValueNotifier<bool> userNew = ValueNotifier<bool>(false);

class UserModel {
  late String id;
  late String name;
  late String upDateName;
  late String date;
  late String email;
  late String token;
  late String status;
  late bool isNotification;
  late num qtyHistory;
  late num qtyComment;

  UserModel({
    required this.id,
    required this.name,
    required this.upDateName,
    required this.date,
    required this.status,
    required this.email,
    required this.token,
    required this.isNotification,
    required this.qtyHistory,
    required this.qtyComment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        upDateName: json['upDateName'],
        date: json["date"],
        email: json['email'],
        token: json['token'],
        status: json['status'],
        isNotification: json['isNotification'],
        qtyHistory: json['qtyHistory'],
        qtyComment: json['qtyComment'],
      );

  static String toJson(UserModel user) => jsonEncode(toMap(user));

  static Map<String, dynamic> toMap(UserModel user) => {
        'id': user.id,
        'name': user.name,
        'upDateName': user.upDateName,
        'date': user.date,
        'email': user.email,
        'token': user.token,
        'isNotification': user.isNotification,
        'status': user.status,
        'qtyHistory': user.qtyHistory,
        'qtyComment': user.qtyComment,
      };
}

class UserClass {
  final AuthService authService = AuthService();
  final ToastComponent toast = ToastComponent();
  final UsersFirestore usersFirestore = UsersFirestore();

  Future<void> clean(BuildContext context, String _status) async {
    try {
      await usersFirestore.pathLoginLogout(UserStatus.INACTIVE.name);
      await authService.logout();
      ActivityUtil(
        ActivitiesEnum.LOGOUT.name,
        DeviceModel(),
        '',
      );
      currentUser.value = [];
      toast.toast(
        context,
        ToastEnum.SUCCESS.name,
        'espero que isso não seja um adeus!',
      );
    } catch (error) {
      debugPrint('ERROR => _setUpQtyHistoryUser:' + error.toString());
      toast.toast(context, ToastEnum.WARNING.name,
          'não foi possível sair da aplicação no momento, tente novamente mais tarde.');
    }
  }

  Future<void> delete(BuildContext context) async {
    try {
      await usersFirestore.pathLoginLogout(UserStatus.DELETED.name);
      await usersFirestore.deleteUser();
      await authService.delete();
      currentUser.value = [];
    } on AuthException catch (error) {
      debugPrint('ERROR => deleteUser: ' + error.toString());
      Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.WARNING.name,
        'não foi possível delatar a conta no momento, tente novamente mais tarde.',
      );
    }
  }

  void add(Map<String, dynamic> _user) {
    currentUser.value = [];
    currentUser.value.add(UserModel.fromJson(_user));
    saveUser();
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

  Future<File> getFileUser() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user.json');
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

  bool isLogin() {
    return currentUser.value.isNotEmpty ? true : false;
  }
}

enum UserStatus { ACTIVE, INACTIVE, DISABLED, DELETED }
