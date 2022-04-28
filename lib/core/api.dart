// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universe_history_app/shared/models/comment_model.dart';
import 'package:universe_history_app/shared/models/history_model.dart';
import 'package:universe_history_app/shared/models/owner_model.dart';
import 'package:universe_history_app/shared/models/user_model.dart';
import 'variables.dart';

class Api {
  CollectionReference activitie =
      FirebaseFirestore.instance.collection('activities');
  CollectionReference block = FirebaseFirestore.instance.collection('blocks');
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');
  CollectionReference denounce =
      FirebaseFirestore.instance.collection('denounces');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference notification =
      FirebaseFirestore.instance.collection('notifications');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  Future<String?> token = FirebaseMessaging.instance.getToken();

  getToken() {
    return token;
  }

  getTokenOwner() {
    return user.where('id', isEqualTo: currentOwner.value.first.id).get();
  }

  setToken(String _token) {
    return user.doc(currentUser.value.first.id).update({'token': _token});
  }

  setBlock(Map<String, dynamic> _form) {
    return block.doc(_form['id']).set(_form);
  }

  setDenounce(Map<String, dynamic> _form) {
    return denounce.doc(_form['id']).set(_form);
  }

  getAllBlock() {
    return block
        .orderBy('date')
        .where('blockerId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

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

  getAllNotification() {
    return notification
        .orderBy('date')
        .where('idUser', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getAllUserHistory() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getHistory(String _idHistory) {
    return history.where('id', isEqualTo: _idHistory).snapshots();
  }

  getComment(String _id) {
    return comment.where('id', isEqualTo: _id).get();
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

  getUsersNickName(String _nickname) {
    return user
        .where('nickname', arrayContainsAny: ['_nickname'])
        .orderBy('nickname')
        .snapshots();
  }

  setHistory(Map<String, dynamic> _form) {
    return history.doc(_form['id']).set(_form);
  }

  setNotification(Map<String, dynamic> _form) {
    return notification.doc(_form['id']).set(_form);
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

  deleteComment() {
    return comment
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  deleteHistory() {
    return history.doc(currentHistory.value.first.id).delete();
  }

  deleteBlock(String blocked) {
    return block.doc(blocked).delete();
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
