// ignore_for_file: unnecessary_new

class Category {
  final String categoryId;
  final String categoryLabel;
  final bool categoryDisabled;

  Category({
    required this.categoryId,
    required this.categoryLabel,
    required this.categoryDisabled,
  });

  static List<Category> allCategories = [
    new Category(
        categoryId: 'maisRecente',
        categoryLabel: '📰 mais recente',
        categoryDisabled: false),
    new Category(
        categoryId: 'favoritas',
        categoryLabel: '⭐ favoritas',
        categoryDisabled: false),
    new Category(
        categoryId: 'familia',
        categoryLabel: '👨‍👨‍👧 família',
        categoryDisabled: false),
    new Category(
        categoryId: 'trabalho',
        categoryLabel: '👔 trabalho',
        categoryDisabled: false),
    new Category(
        categoryId: 'estudos',
        categoryLabel: '🎓 estudos',
        categoryDisabled: false),
    new Category(
        categoryId: 'ciencias',
        categoryLabel: '🧪 ciências',
        categoryDisabled: false),
    new Category(
        categoryId: 'geografia',
        categoryLabel: '🗺️ geografia',
        categoryDisabled: false),
    new Category(
        categoryId: 'comida',
        categoryLabel: '🍜 comida',
        categoryDisabled: false),
    new Category(
        categoryId: 'bebida',
        categoryLabel: '🍹 bebida',
        categoryDisabled: false),
    new Category(
        categoryId: 'dinheiro',
        categoryLabel: '🪙 dinheiro',
        categoryDisabled: false),
    new Category(
        categoryId: 'terror',
        categoryLabel: '😱 terror',
        categoryDisabled: false),
    new Category(
        categoryId: 'romance',
        categoryLabel: '❤️ romance',
        categoryDisabled: false),
    new Category(
        categoryId: 'esportes',
        categoryLabel: '🏐 esportes',
        categoryDisabled: false),
    new Category(
        categoryId: 'veiculos',
        categoryLabel: '🚗 veículos',
        categoryDisabled: false),
    new Category(
        categoryId: 'cultura',
        categoryLabel: '🎨 cultura',
        categoryDisabled: false),
    new Category(
        categoryId: 'violencia',
        categoryLabel: '🔫 violência',
        categoryDisabled: false),
    new Category(
        categoryId: 'comedia',
        categoryLabel: '😆 comedia',
        categoryDisabled: false),
    new Category(
        categoryId: 'musica',
        categoryLabel: '🎵 música',
        categoryDisabled: false),
    new Category(
        categoryId: 'tvFilmesSeries',
        categoryLabel: '📺 tv, filmes e series',
        categoryDisabled: false),
    new Category(
        categoryId: 'sexo', categoryLabel: '♾️ sexo', categoryDisabled: false),
    new Category(
        categoryId: 'beleza',
        categoryLabel: '💇🏽 beleza',
        categoryDisabled: false),
    new Category(
        categoryId: 'moda', categoryLabel: '👗 moda', categoryDisabled: false),
    new Category(
        categoryId: 'animais',
        categoryLabel: '🐈 animais',
        categoryDisabled: false),
    new Category(
        categoryId: 'extraterrestre',
        categoryLabel: '👽 extraterrestre',
        categoryDisabled: false),
    new Category(
        categoryId: 'religiao',
        categoryLabel: '⛪ religião',
        categoryDisabled: false),
    new Category(
        categoryId: 'saude',
        categoryLabel: '🫁 saúde',
        categoryDisabled: false),
    new Category(
        categoryId: 'cienciasTecnologia',
        categoryLabel: '💻 ciências e tecnologia',
        categoryDisabled: false),
    new Category(
        categoryId: 'entretenimento',
        categoryLabel: '🎭 entretenimento',
        categoryDisabled: false),
    new Category(
        categoryId: 'transportes',
        categoryLabel: '🚌 transportes',
        categoryDisabled: false),
    new Category(
        categoryId: 'eventos',
        categoryLabel: '🎫 eventos',
        categoryDisabled: false),
    new Category(
        categoryId: 'tatuagemPiercing',
        categoryLabel: '➿ tatuagem e piercing',
        categoryDisabled: false),
    new Category(
        categoryId: 'fotografiaVideos',
        categoryLabel: '🎥 fotografia e vídeos',
        categoryDisabled: false),
    new Category(
        categoryId: 'climaTempo',
        categoryLabel: '⛅ clima e tempo',
        categoryDisabled: false),
    new Category(
        categoryId: 'astrologia',
        categoryLabel: '♏ astrologia',
        categoryDisabled: false),
    new Category(
        categoryId: 'astronomia',
        categoryLabel: '🚀 astronomia',
        categoryDisabled: false),
  ];
}
