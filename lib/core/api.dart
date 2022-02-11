import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  final bookmark = FirebaseFirestore.instance.collection('bookmarks');
  final history = FirebaseFirestore.instance.collection('historys');

  getAllHistory() {
    snapshot = history.snapshots();
    return snapshot;
  }

  getAllHistoryFiltered(String filter) {
    snapshot = history
        .orderBy('date')
        .where('categories', arrayContainsAny: [filter]).snapshots();
    return snapshot;
  }

  getAllUserBookmarks(String user) {
    snapshot = bookmark
        .orderBy('date')
        .where('user', arrayContainsAny: [user]).snapshots();
    return snapshot;
  }

  getAllUserHistory(String user) {
    snapshot = history
        .orderBy('date')
        .where('user.id', arrayContainsAny: [user]).snapshots();
    return snapshot;
  }

  setHistory(form) {
    return history.doc().set(form);
  }
}
