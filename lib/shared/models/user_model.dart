// ignore_for_file: unnecessary_new

import 'package:universe_history_app/core/variables.dart';

class UserModel {
  final String id;
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

  static Set<UserModel> user = {
    UserModel(
      id: currentUser.value.id,
      nickname: currentUser.value.nickname,
      date: currentUser.value.date,
      isDisabled: currentUser.value.isDisabled,
      email: currentUser.value.email,
      channel: currentUser.value.channel,
    )
  };
}
