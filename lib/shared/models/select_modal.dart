// ignore_for_file: unnecessary_new

class SelectModel {
  final int id;
  final String label;

  SelectModel({
    required this.id,
    required this.label,
  });

  static List<SelectModel> allPrivacy = [
    new SelectModel(id: 0, label: "assinar história como anonimo"),
    new SelectModel(id: 1, label: "assinar história com seu nome de usuário"),
  ];

  static List<SelectModel> allComment = [
    new SelectModel(id: 0, label: "habilitar comentários na história"),
    new SelectModel(id: 1, label: "desabilitar comentários na história"),
  ];
}
