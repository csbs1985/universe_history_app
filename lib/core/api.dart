// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'variables.dart';

class Api {
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');
  CollectionReference activitie =
      FirebaseFirestore.instance.collection('activities');

  getAllComment() {
    return comment
        .orderBy('date', descending: true)
        .where('historyId', isEqualTo: currentHistory.value.first.id)
        .snapshots();
  }

  getAllHistory() {
    return history.orderBy('date').snapshots();
  }

  getAllActivities() {
    return activitie
        .where('userId', isEqualTo: currentUser.value.first.id)
        .orderBy('date')
        .snapshots();
  }

  getAllHistoryFiltered(String _filter) {
    return history
        .orderBy('date')
        .where('categories', arrayContainsAny: [_filter]).snapshots();
  }

  getAllBookmarks() {
    return bookmark.orderBy('date').where('user',
        arrayContainsAny: [currentUser.value.first.id]).snapshots();
  }

  getAllUserHistory() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getHistory() {
    return history
        .where('id', isEqualTo: currentHistory.value.first.id)
        .snapshots();
  }

  getUser(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getNickName(String _nickname) {
    return user.where('nickname', isEqualTo: _nickname).get();
  }

  getSearchNickName(String _nickname) {
    return user.where('nickname', arrayContainsAny: ['_nickname']).snapshots();
  }

  getHistoryNickName(String _nickname) {
    return history
        .where('nickname', arrayContains: _nickname)
        .orderBy('nickname')
        .snapshots();
  }

  setHistory(Map<String, dynamic> _form) {
    return history.doc(_form['id']).set(_form);
  }

  setActivities(Map<String, dynamic> _form) {
    return activitie.doc().set(_form);
  }

  setComment(Map<String, dynamic> _form) {
    return comment.doc(_form['id']).set(_form);
  }

  setUser(Map<String, dynamic> _form) {
    return user.doc(currentUser.value.first.id).set(_form);
  }

  upBookmarks() {
    return bookmark
        .doc(currentUser.value.first.id)
        .update({'historyId': currentBookmarks.value});
  }

  upNumComment() {
    return history
        .doc(currentDocHistory.value)
        .update({'qtyComment': currentHistory.value.first.qtyComment});
  }

  upNickName() {
    return user
        .doc(currentUser.value.first.id)
        .update({'nickname': currentUser.value.first.nickname});
  }

  upNotification() {
    return user
        .doc(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }

  setUpQtyHistoryUser() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyHistory': currentUser.value.first.qtyHistory});
  }

  setUpQtyCommentUser() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyComment': currentUser.value.first.qtyComment});
  }
}
