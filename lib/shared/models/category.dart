// ignore_for_file: unnecessary_new

class Category {
  final String id;
  final String label;
  final bool disabled;

  Category({
    required this.id,
    required this.label,
    required this.disabled,
  });

  static List<Category> allCategories = [
    new Category(id: 'maisRecente', label: '📰 mais recente', disabled: false),
    new Category(id: 'favoritas', label: '⭐ favoritas', disabled: false),
    new Category(id: 'animais', label: '🐈 animais', disabled: false),
    new Category(id: 'astrologia', label: '♏ astrologia', disabled: false),
    new Category(id: 'astronomia', label: '🚀 astronomia', disabled: false),
    new Category(id: 'bebida', label: '🍹 bebida', disabled: false),
    new Category(id: 'beleza', label: '💇🏽 beleza', disabled: false),
    new Category(id: 'ciencias', label: '🧪 ciências', disabled: false),
    new Category(id: 'climaTempo', label: '⛅ clima e tempo', disabled: false),
    new Category(id: 'comedia', label: '😆 comedia', disabled: false),
    new Category(id: 'comida', label: '🍜 comida', disabled: false),
    new Category(id: 'cultura', label: '🎨 cultura', disabled: false),
    new Category(id: 'dinheiro', label: '🪙 dinheiro', disabled: false),
    new Category(
        id: 'entretenimento', label: '🎭 entretenimento', disabled: false),
    new Category(id: 'esportes', label: '🏐 esportes', disabled: false),
    new Category(id: 'estudos', label: '🎓 estudos', disabled: false),
    new Category(id: 'eventos', label: '🎫 eventos', disabled: false),
    new Category(
        id: 'extraterrestre', label: '👽 extraterrestre', disabled: false),
    new Category(id: 'familia', label: '👨‍👨‍👧 família', disabled: false),
    new Category(
        id: 'fotografiaVideos',
        label: '🎥 fotografia e vídeos',
        disabled: false),
    new Category(id: 'geografia', label: '🗺️ geografia', disabled: false),
    new Category(id: 'moda', label: '👗 moda', disabled: false),
    new Category(id: 'musica', label: '🎵 música', disabled: false),
    new Category(id: 'religiao', label: '⛪ religião', disabled: false),
    new Category(id: 'romance', label: '❤️ romance', disabled: false),
    new Category(id: 'saude', label: '🫁 saúde', disabled: false),
    new Category(id: 'sexo', label: '♾️ sexo', disabled: false),
    new Category(
        id: 'tatuagemPiercing',
        label: '➿ tatuagem e piercing',
        disabled: false),
    new Category(id: 'tecnologia', label: '💻 tecnologia', disabled: false),
    new Category(id: 'terror', label: '😱 terror', disabled: false),
    new Category(id: 'trabalho', label: '👔 trabalho', disabled: false),
    new Category(id: 'transportes', label: '🚌 transportes', disabled: false),
    new Category(
        id: 'tvFilmesSeries', label: '📺 tv, filmes e séries', disabled: false),
    new Category(id: 'veiculos', label: '🚗 veículos', disabled: false),
    new Category(id: 'violencia', label: '🔫 violência', disabled: false),
  ];
}
