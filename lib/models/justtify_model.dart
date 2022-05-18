// ignore_for_file: unnecessary_new

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
    new JustifyModel(id: '0', title: 'Quero remover algo', text: ''),
    new JustifyModel(id: '1', title: 'Problemas para começar', text: ''),
    new JustifyModel(id: '2', title: 'Passo muito tempo aqui', text: ''),
    new JustifyModel(
        id: '3', title: 'Não vejo motivo para usar o History', text: ''),
    new JustifyModel(id: '4', title: 'Questões de privacidade', text: ''),
    new JustifyModel(
        id: '5', title: 'Usuários não respeitam as regras', text: ''),
    new JustifyModel(id: '6', title: 'Aplicação complicada de mexer', text: ''),
    new JustifyModel(id: '7', title: 'Conteúdo pouco relevante', text: ''),
    new JustifyModel(id: '8', title: 'Layout da aplicação confusa', text: ''),
    new JustifyModel(id: '9', title: 'Outro motivo não listado', text: ''),
  ];
}
