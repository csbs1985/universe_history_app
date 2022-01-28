// ignore_for_file: unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String name;
  final String nickname;
  final String dateRegister;
  final bool isDisabled;

  UserModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.dateRegister,
    required this.isDisabled,
  });

  static Set<UserModel> user = {
    new UserModel(
      id: 'charlesSantos',
      name: 'Charles Santos',
      nickname: 'charles.sbs',
      dateRegister: '2 de janeiro de 2022',
      isDisabled: false,
    )
  };
}

User getCurrentId() {
  late User _currentUser;

  FirebaseAuth.instance.authStateChanges().listen((user) {
    _currentUser = user!;
  });

  return _currentUser;
}
