// ignore_for_file: unnecessary_new

class CheckboxModel {
  final int id;
  final String label;

  CheckboxModel({
    required this.id,
    required this.label,
  });

  static List<CheckboxModel> allPrivacy = [
    new CheckboxModel(id: 0, label: "Assinar história como anonimo"),
    new CheckboxModel(id: 1, label: "Assinar historia com seu nome de usuário"),
  ];

  static List<CheckboxModel> allComment = [
    new CheckboxModel(id: 0, label: "Habilitar comentários de outros usuários"),
    new CheckboxModel(
        id: 1, label: "Desabilitar comentários de outros usuários"),
  ];
}
