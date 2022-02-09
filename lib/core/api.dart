import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  final bookmark =
      FirebaseFirestore.instance.collection('bookmarks').orderBy('date');
  final history =
      FirebaseFirestore.instance.collection('historys').orderBy('date');

  getAllHistory() {
    snapshot = history.snapshots();
    return snapshot;
  }

  getAllHistoryFiltered(String filter) {
    snapshot =
        history.where('categories', arrayContainsAny: [filter]).snapshots();
    return snapshot;
  }

  getAllUserBookmarks(String user) {
    snapshot = bookmark.where('user', arrayContainsAny: [user]).snapshots();
    return snapshot;
  }

  getAllUserHistory(String user) {
    snapshot = history.where('user.id', arrayContainsAny: [user]).snapshots();
    return snapshot;
  }

  setHistory(form) {
    FirebaseFirestore.instance.collection('historys').doc().set(form);
  }
}
