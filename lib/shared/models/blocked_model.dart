// ignore_for_file: unnecessary_new

class BlockedModel {
  final String id;
  final String user;
  final String blocked;
  final String date;

  BlockedModel({
    required this.id,
    required this.user,
    required this.blocked,
    required this.date,
  });

  static List<BlockedModel> allBlocked = [
    new BlockedModel(
        id: '0',
        user: 'charles.sbs',
        blocked: 'luiza',
        date: '18 de janeiro de 2022 às 16:26'),
    new BlockedModel(
        id: '0',
        user: 'charles.sbs',
        blocked: 'sabrina',
        date: '18 de janeiro de 2022 às 16:26'),
  ];
}
