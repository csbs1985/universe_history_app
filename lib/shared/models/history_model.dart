// ignore_for_file: non_constant_identifier_names, unnecessary_new

class HistoryModel {
  final String id;
  final String title;
  final String text;
  final String date;
  final bool isComment;
  final bool isAnonymous;
  final bool edit;
  final bool delete;
  final String user;
  final int quantity;
  final List<String> categories;

  HistoryModel({
    required this.id,
    required this.title,
    required this.text,
    required this.date,
    required this.isComment,
    required this.isAnonymous,
    required this.edit,
    required this.delete,
    required this.user,
    required this.quantity,
    required this.categories,
  });

  static List<HistoryModel> allHistory = [
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'Quando penso no que fiz',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis. Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: true,
      edit: false,
      delete: false,
      isAnonymous: false,
      user: 'fbjfbdj01',
      quantity: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'O dia em que quase morri por três vezes',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: false,
      edit: false,
      delete: false,
      isAnonymous: true,
      user: 'fbjfbdj01',
      quantity: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'Quando penso no que fiz',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: true,
      edit: false,
      delete: false,
      isAnonymous: false,
      user: 'fbjfbdj01',
      quantity: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
    new HistoryModel(
      id: 'bvjbsbvsu01',
      title: 'O dia em que quase morri por três vezes',
      text:
          'Mussum Ipsum, cacilds vidis litro abertis. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis! Casamentiss faiz malandris se pirulitá. Mé faiz elementum girarzis, nisi eros vermeio. Suco de cevadiss, é um leite divinis, qui tem lupuliz, matis, aguis e fermentis.',
      date: '2 de janeiro de 2022',
      isComment: false,
      edit: false,
      delete: false,
      isAnonymous: true,
      user: 'fbjfbdj01',
      quantity: 1,
      categories: ['fbjfbdj01', 'gfsdgdg02'],
    ),
  ];
}
