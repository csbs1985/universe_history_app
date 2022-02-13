import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';

class Api {
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');

  getAllComment(String id) {
    return comment
        .orderBy('date')
        .where('historyId', arrayContainsAny: [id]).snapshots();
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

  setHistory(Map<String, dynamic> form) {
    return history.doc().set(form);
  }

  setComment(CommentModel form) {
    return comment.doc().set(form);
  }
}
