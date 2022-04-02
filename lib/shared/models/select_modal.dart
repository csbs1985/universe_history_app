// ignore_for_file: unnecessary_new

import 'package:universe_history_app/shared/models/user_model.dart';

class SelectModel {
  final int id;
  final String label;

  SelectModel({
    required this.id,
    required this.label,
  });

  static List<SelectModel> allPrivacy = [
    new SelectModel(id: 0, label: "assinar história como anônimo"),
    new SelectModel(
        id: 1,
        label: "assinar história como ${currentUser.value.first.nickname}"),
  ];

  static List<SelectModel> allComment = [
    new SelectModel(id: 0, label: "habilitar comentários na história"),
    new SelectModel(id: 1, label: "desabilitar comentários na história"),
  ];
}

bool isAnonymous(value) {
  return value == 0 ? true : false;
}

bool isComment(value) {
  return value == 0 ? true : false;
}
