// ignore_for_file: unnecessary_new

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
}
