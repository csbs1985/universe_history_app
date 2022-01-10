// ignore_for_file: unnecessary_new

class Checkbox {
  final int id;
  final String label;

  Checkbox({
    required this.id,
    required this.label,
  });

  static List<Checkbox> allPrivacy = [
    new Checkbox(id: 0, label: "assinar história como anonimo"),
    new Checkbox(id: 1, label: "assinar história com seu nome de usuário"),
  ];

  static List<Checkbox> allComment = [
    new Checkbox(id: 0, label: "habilitar comentários na história"),
    new Checkbox(id: 1, label: "desabilitar comentários na história"),
  ];
}
