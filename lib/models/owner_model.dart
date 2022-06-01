import 'package:flutter/cupertino.dart';

ValueNotifier<List<OwnerModel>> currentOwner =
    ValueNotifier<List<OwnerModel>>([]);

class OwnerModel {
  late String id;
  late String name;
  late String token;
  late String userStatus;

  OwnerModel(
      {required this.id,
      required this.name,
      required this.token,
      required this.userStatus});

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      OwnerModel.fromMap(json);

  factory OwnerModel.fromMap(Map<String, dynamic> json) => OwnerModel(
        id: json['id'],
        name: json['name'],
        token: json['token'],
        userStatus: json['userStatus'],
      );
}

class OwnerClass {
  void selectOwner(
    String _id,
    String _userName,
    String _token,
    String _userStatus,
  ) {
    var owner = {
      'id': _id,
      'name': _userName,
      'token': _token,
      'userStatus': _userStatus
    };
    currentOwner.value = [];
    currentOwner.value.add(OwnerModel.fromJson(owner));
  }
}
