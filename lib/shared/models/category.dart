// ignore_for_file: unnecessary_new

class CategoryModel {
  final String categoryId;
  final String categoryLabel;
  final String categorValue;
  final bool categoryDisabled;

  CategoryModel({
    required this.categoryId,
    required this.categoryLabel,
    required this.categorValue,
    required this.categoryDisabled,
  });

  static List<CategoryModel> user = [
    new CategoryModel(
        categoryId: 'fbjfbdj01',
        categoryLabel: 'viagem',
        categorValue: 'viagem',
        categoryDisabled: false),
    new CategoryModel(
        categoryId: 'gfsdgdg02',
        categoryLabel: 'amor',
        categorValue: 'amor',
        categoryDisabled: false),
  ];
}
