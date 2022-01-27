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
  // final List<CategoryModel> categories; TODO: trocar pela linha de cima quando correto.

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

  static List<HistoryModel> allHistory = [
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'Quando penso no que fiz',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: true,
      isEdit: false,
      isDelete: false,
      isAnonymous: false,
      userId: 'fbjfbdj01',
      qtyComment: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'O dia em que quase morri por três vezes',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: false,
      isEdit: false,
      isDelete: false,
      isAnonymous: true,
      userId: 'fbjfbdj01',
      qtyComment: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'Quando penso no que fiz',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: true,
      isEdit: false,
      isDelete: false,
      isAnonymous: false,
      userId: 'fbjfbdj01',
      qtyComment: 23,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'O dia em que quase morri por três vezes',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: false,
      isEdit: false,
      isDelete: false,
      isAnonymous: true,
      userId: 'fbjfbdj01',
      qtyComment: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
  ];
}
