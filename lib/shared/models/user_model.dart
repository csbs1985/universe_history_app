// ignore_for_file: unnecessary_new

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

String getCurrentId() {
  return 'charles.sbs';
}
