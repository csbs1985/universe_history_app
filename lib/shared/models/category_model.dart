// ignore_for_file: unnecessary_new

class CategoryModel {
  final String id;
  final String label;
  final bool disabled;

  CategoryModel({
    required this.id,
    required this.label,
    required this.disabled,
  });

  static List<CategoryModel> allCategories = [
    new CategoryModel(id: 'minhas', label: 'minhas', disabled: false),
    new CategoryModel(id: 'todas', label: 'todas', disabled: false),
    new CategoryModel(id: 'favoritas', label: 'favoritas', disabled: false),
    new CategoryModel(id: 'animais', label: 'animais', disabled: false),
    new CategoryModel(id: 'astrologia', label: 'astrologia', disabled: false),
    new CategoryModel(id: 'astronomia', label: 'astronomia', disabled: false),
    new CategoryModel(id: 'bebida', label: 'bebida', disabled: false),
    new CategoryModel(id: 'beleza', label: 'beleza', disabled: false),
    new CategoryModel(id: 'ciencias', label: 'ciências', disabled: false),
    new CategoryModel(
        id: 'climaTempo', label: 'clima e tempo', disabled: false),
    new CategoryModel(id: 'comedia', label: 'comédia', disabled: false),
    new CategoryModel(id: 'comida', label: 'comida', disabled: false),
    new CategoryModel(id: 'cultura', label: 'cultura', disabled: false),
    new CategoryModel(id: 'dinheiro', label: 'dinheiro', disabled: false),
    new CategoryModel(
        id: 'entretenimento', label: 'entretenimento', disabled: false),
    new CategoryModel(id: 'esportes', label: 'esportes', disabled: false),
    new CategoryModel(id: 'estudos', label: 'estudos', disabled: false),
    new CategoryModel(id: 'eventos', label: 'eventos', disabled: false),
    new CategoryModel(
        id: 'extraterrestre', label: 'extraterrestre', disabled: false),
    new CategoryModel(id: 'familia', label: 'família', disabled: false),
    new CategoryModel(
        id: 'fotografiaVideos', label: 'fotografia e vídeos', disabled: false),
    new CategoryModel(id: 'geografia', label: 'geografia', disabled: false),
    new CategoryModel(id: 'internet', label: 'internet', disabled: false),
    new CategoryModel(id: 'moda', label: 'moda', disabled: false),
    new CategoryModel(id: 'musica', label: 'música', disabled: false),
    new CategoryModel(id: 'religiao', label: 'religião', disabled: false),
    new CategoryModel(id: 'romance', label: 'romance', disabled: false),
    new CategoryModel(id: 'saude', label: 'saúde', disabled: false),
    new CategoryModel(id: 'sexo', label: 'sexo', disabled: false),
    new CategoryModel(
        id: 'tatuagemPiercing', label: 'tatuagem e piercing', disabled: false),
    new CategoryModel(id: 'tecnologia', label: 'tecnologia', disabled: false),
    new CategoryModel(id: 'terror', label: 'terror', disabled: false),
    new CategoryModel(id: 'trabalho', label: 'trabalho', disabled: false),
    new CategoryModel(id: 'transportes', label: 'transportes', disabled: false),
    new CategoryModel(
        id: 'tvFilmesSeries', label: 'tv, filmes e séries', disabled: false),
    new CategoryModel(id: 'veiculos', label: 'veículos', disabled: false),
    new CategoryModel(id: 'violencia', label: 'violência', disabled: false),
  ];
}
