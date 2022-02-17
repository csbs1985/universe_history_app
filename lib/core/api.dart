// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'variables.dart';

class Api {
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');

  getAllComment() {
    return comment
        .orderBy('date', descending: true)
        .where('historyId', isEqualTo: currentHistory.value)
        .snapshots();
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
    return history.orderBy('date').where('userId', isEqualTo: user).snapshots();
  }

  getUser(String email) {
    return user.where('email', isEqualTo: email).get();
  }

  getHistory() {
    return history.where('historyId', isEqualTo: currentHistory.value).get();
  }

  setHistory(Map<String, dynamic> form) {
    return history.doc().set(form);
  }

  setComment(Map<String, dynamic> form) {
    return comment.doc().set(form);
  }

  upBookmarks(String user) {
    return bookmark.doc(user).update({'historyId': currentBookmarks.value});
  }

  upNumComment() {
    return history
        .doc(currentHistory.value)
        .update({'qtyComment': currentQtyComment.value});
  }
}
