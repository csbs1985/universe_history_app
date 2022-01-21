// ignore_for_file: unnecessary_new

class JustifyModel {
  final String id;
  final String label;

  JustifyModel({
    required this.id,
    required this.label,
  });

  static List<JustifyModel> allJustify = [
    new JustifyModel(id: '0', label: 'Quero remover algo'),
    new JustifyModel(id: '1', label: 'Problemas para começar'),
    new JustifyModel(id: '2', label: 'Passo muito tempo aqui'),
    new JustifyModel(id: '3', label: 'Não vejo motivo para usar o History'),
    new JustifyModel(id: '4', label: 'Questões de privacidade'),
    new JustifyModel(id: '5', label: 'Usuários não respeitam as regras'),
    new JustifyModel(id: '6', label: 'Aplicação complicada de mexer.'),
    new JustifyModel(id: '7', label: 'Conteúdo pouco relevante'),
    new JustifyModel(id: '8', label: 'Layout da aplicação confusa'),
  ];
}
