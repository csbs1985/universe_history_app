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

  static Set<UserModel> user = {
    new UserModel(
      id: 'd31q2laUIRDwLdfK8cCA',
      nickname: 'charles.sbs',
      date: DateTime.now(),
      isDisabled: false,
      email: 'csbs.conta@outlook.com',
      channel: 'google',
    )
  };
}

String getCurrentId() {
  return UserModel.user.first.id;
}

// d31q2laUIRDwLdfK8cCA