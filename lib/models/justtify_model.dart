class JustifyModel {
  final String id;
  final String title;
  final String text;

  JustifyModel({
    required this.id,
    required this.title,
    required this.text,
  });

  static List<JustifyModel> allJustify = [
    JustifyModel(id: '0', title: 'Quero remover algo', text: ''),
    JustifyModel(id: '1', title: 'Problemas para começar', text: ''),
    JustifyModel(id: '2', title: 'Passo muito tempo aqui', text: ''),
    JustifyModel(
        id: '3', title: 'Não vejo motivo para usar o History', text: ''),
    JustifyModel(id: '4', title: 'Questões de privacidade', text: ''),
    JustifyModel(id: '5', title: 'Usuários não respeitam as regras', text: ''),
    JustifyModel(id: '6', title: 'Aplicação complicada de mexer', text: ''),
    JustifyModel(id: '7', title: 'Conteúdo pouco relevante', text: ''),
    JustifyModel(id: '8', title: 'Layout da aplicação confusa', text: ''),
    JustifyModel(id: '9', title: 'Outro motivo não listado', text: ''),
  ];
}
