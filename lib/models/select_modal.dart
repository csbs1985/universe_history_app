import 'package:universe_history_app/models/user_model.dart';

class SelectModel {
  final int id;
  final String label;

  SelectModel({
    required this.id,
    required this.label,
  });

  static List<SelectModel> allPrivacy = [
    SelectModel(id: 0, label: "assinar história como anônimo"),
    SelectModel(
        id: 1,
        label: "assinar história como ${currentUser.value.first.nickname}"),
  ];

  static List<SelectModel> allComment = [
    SelectModel(id: 0, label: "habilitar comentários na história"),
    SelectModel(id: 1, label: "desabilitar comentários na história"),
  ];
}

bool isSigned(value) {
  return value == 0 ? true : false;
}

bool isComment(value) {
  return value == 0 ? true : false;
}
