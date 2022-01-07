// ignore_for_file: unnecessary_new

class UserModel {
  final String userId;
  final String userName;
  final String userNickname;
  final String userRegister;
  final bool userDisabled;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userNickname,
    required this.userRegister,
    required this.userDisabled,
  });

  static Set<UserModel> user = {
    new UserModel(
        userId: 'fbjfbdj01',
        userName: 'Charles Santos',
        userNickname: 'charles.sbs',
        userRegister: '2 de janeiro de 2022',
        userDisabled: false)
  };
}
