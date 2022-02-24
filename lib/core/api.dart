// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'variables.dart';

class Api {
  final CurrentUser currentUser = CurrentUser([]);

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

  getAllHistoryFiltered(String _filter) {
    return history
        .orderBy('date')
        .where('categories', arrayContainsAny: [_filter]).snapshots();
  }

  getAllUserBookmarks() {
    return bookmark.orderBy('date').where('user',
        arrayContainsAny: [currentUser.value.first.id]).snapshots();
  }

  getAllUserHistory() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getUser(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getHistory() {
    return history.where('historyId', isEqualTo: currentHistory.value).get();
  }

  setHistory(Map<String, dynamic> _form) {
    return history.doc().set(_form);
  }

  setComment(Map<String, dynamic> _form) {
    return comment.doc().set(_form);
  }

  setUser(Map<String, dynamic> _form, String _id) {
    return user.doc(_id).set(_form);
  }

  upBookmarks(String _user) {
    return bookmark.doc(_user).update({'historyId': currentBookmarks.value});
  }

  upNumComment() {
    return history
        .doc(currentHistory.value)
        .update({'qtyComment': currentQtyComment.value});
  }
}
