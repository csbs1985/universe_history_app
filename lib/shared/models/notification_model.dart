// ignore_for_file: unnecessary_new

class NotificationModel {
  final String id;
  final String user;
  final String history;
  final String date;
  final bool anonimous;
  final bool read;

  NotificationModel({
    required this.id,
    required this.user,
    required this.history,
    required this.date,
    required this.anonimous,
    required this.read,
  });

  static List<NotificationModel> allNotification = [
    new NotificationModel(
        id: '0',
        user: 'charles.sbs',
        history: 'Classificados Vila Prudente e região',
        date: 'qui.às 17:18',
        anonimous: false,
        read: false),
    new NotificationModel(
        id: '1',
        user: 'luizaLuluca',
        history: 'expands property',
        date: 'qui.às 17:18',
        anonimous: false,
        read: false),
    new NotificationModel(
        id: '2',
        user: 'luizaLuluca',
        history: 'expands property',
        date: 'qui.às 17:18',
        anonimous: true,
        read: true),
  ];
}
