import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final bookmark = FirebaseFirestore.instance.collection('bookmarks');
  final history = FirebaseFirestore.instance.collection('historys');

  getAllHistory() {
    return history.orderBy('date').snapshots();
  }

  getAllHistoryFiltered(String filter) {
    return history
        .orderBy('date')
        .where('categories', arrayContainsAny: [filter]).snapshots();
  }

  getAllUserBookmarks(String user) {
    return bookmark
        .orderBy('date')
        .where('user', arrayContainsAny: [user]).snapshots();
  }

  getAllUserHistory(String user) {
    return history
        .orderBy('date')
        .where('user.id', arrayContainsAny: [user]).snapshots();
  }

  setHistory(form) {
    return history.doc().set(form);
  }
}
