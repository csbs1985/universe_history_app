// ignore_for_file: unnecessary_new

class User {
  final String id;
  final String name;
  final String nickname;
  final String dateRegister;
  final bool disabled;

  User({
    required this.id,
    required this.name,
    required this.nickname,
    required this.dateRegister,
    required this.disabled,
  });

  static Set<User> user = {
    new User(
        id: 'charlesSantos',
        name: 'Charles Santos',
        nickname: 'charles.sbs',
        dateRegister: '2 de janeiro de 2022',
        disabled: false)
  };
}
