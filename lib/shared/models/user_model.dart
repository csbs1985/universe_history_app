// ignore_for_file: unnecessary_new

class UserModel {
  final String id;
  final String name;
  final String nickname;
  final String date;
  final bool isDisabled;

  UserModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.date,
    required this.isDisabled,
  });

  static Set<UserModel> user = {
    new UserModel(
      id: 'charlesSantos',
      name: 'Charles Santos',
      nickname: 'charles.sbs',
      date: '2 de janeiro de 2022',
      isDisabled: false,
    )
  };
}

String getCurrentId() {
  return 'charles.sbs';
}
