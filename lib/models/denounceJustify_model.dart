// ignore_for_file: file_names, unnecessary_new, non_constant_identifier_names

class DenounceJustifyModel {
  DenounceJustifyModel({
    required this.id,
    required this.title,
    required this.text,
  });

  late String id;
  late String title;
  late String text;

  static List<DenounceJustifyModel> AllDenounceJustify = [
    new DenounceJustifyModel(
        id: "0", title: "Fingindo ser outra pessoa", text: ""),
    new DenounceJustifyModel(id: "1", title: "Conta falsa", text: ""),
    new DenounceJustifyModel(
        id: "2", title: "Suicídio ou automotilação", text: ""),
    new DenounceJustifyModel(id: "3", title: "Conteúdo inadequado", text: ""),
    new DenounceJustifyModel(id: "4", title: "Assédio moral", text: ""),
    new DenounceJustifyModel(id: "5", title: "Assédio sexual", text: ""),
    new DenounceJustifyModel(id: "6", title: "Bullying", text: ""),
    new DenounceJustifyModel(id: "7", title: "Quero ajudar alguém", text: ""),
    new DenounceJustifyModel(id: "8", title: "Span", text: ""),
    new DenounceJustifyModel(id: "9", title: "Terrorismo", text: ""),
    new DenounceJustifyModel(id: "10", title: "Discurso de ódio", text: ""),
    new DenounceJustifyModel(id: "11", title: "Venda não autorizada", text: ""),
    new DenounceJustifyModel(id: "14", title: "Outra coisa", text: "")
  ];
}
