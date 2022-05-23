class FavoriteModel {
  final String id;
  final String history;
  final String user;

  FavoriteModel({
    required this.id,
    required this.history,
    required this.user,
  });

  static List<FavoriteModel> allFavorite = [
    FavoriteModel(
      id: '0',
      user: 'charlesSantos',
      history: '0',
    ),
    FavoriteModel(
      id: '1',
      user: 'charlesSantos',
      history: '1',
    ),
    FavoriteModel(
      id: '2',
      user: 'charlesSantos',
      history: '2',
    ),
  ];
}
