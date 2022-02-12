import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');

  getAllComment() {
    return comment.orderBy('date').where('field').snapshots();
  }

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
        .where('userId', arrayContainsAny: [user]).snapshots();
  }

  getUser(String email) {
    return user.where('email', isEqualTo: email).get();
  }

  setHistory(form) {
    return history.doc().set(form);
  }

  setComment(comment) {
    return comment.doc().set(comment);
  }
}
