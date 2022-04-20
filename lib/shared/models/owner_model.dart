// ignore_for_file: unnecessary_new, invalid_return_type_for_catch_error, avoid_print, unused_local_variable, avoid_returning_null_for_void

import 'package:flutter/cupertino.dart';

ValueNotifier<List<OwnerModel>> currentOwner =
    ValueNotifier<List<OwnerModel>>([]);

class OwnerModel {
  late String id;
  late String nickname;

  OwnerModel({
    required this.id,
    required this.nickname,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      OwnerModel.fromMap(json);

  factory OwnerModel.fromMap(Map<String, dynamic> json) => OwnerModel(
        id: json['id'],
        nickname: json['nickname'],
      );
}

class OwnerClass {
  void selectOwner(String _id, String _userNickName) {
    var owner = {'id': _id, 'nickname': _userNickName};
    currentOwner.value = [];
    currentOwner.value.add(OwnerModel.fromJson(owner));
  }
}
