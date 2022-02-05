// ignore_for_file: non_constant_identifier_names, unnecessary_new

class HistoryModel {
  final String id;
  final String title;
  final String text;
  final String date;
  final String userId;
  final bool isComment;
  final bool isAnonymous;
  final bool isEdit;
  final bool isDelete;
  final int qtyComment;
  final List<String> categories;

  HistoryModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.isComment,
    required this.isAnonymous,
    required this.isEdit,
    required this.isDelete,
    required this.userId,
    required this.qtyComment,
    required this.categories,
  });

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        date = json['date'],
        isComment = json['isComment'],
        isAnonymous = json['isAnonymous'],
        isEdit = json['isEdit'],
        isDelete = json['isDelete'],
        userId = json['userId'],
        qtyComment = json['qtyComment'],
        categories = json['categories'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'text': text,
        'date': date,
        'isComment': isComment,
        'isAnonymous': isAnonymous,
        'isEdit': isEdit,
        'isDelete': isDelete,
        'userId': userId,
        'qtyComment': qtyComment,
        'categories': categories,
      };
}
