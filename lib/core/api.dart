import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'variables.dart';

class Api {
  CollectionReference activitie =
      FirebaseFirestore.instance.collection('activities');
  CollectionReference justification =
      FirebaseFirestore.instance.collection('justifications');
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

  getTokenOwner(String _user) {
    return user.where('id', isEqualTo: _user).get();
  }

  setBlock(Map<String, dynamic> _form) {
    return block.doc(_form['id']).set(_form);
  }

  setDenounce(Map<String, dynamic> _form) {
    return denounce.doc(_form['id']).set(_form);
  }

  setJustify(Map<String, dynamic> _form) {
    return justification.doc(_form['id']).set(_form);
  }

  getAllBlock() {
    return block
        .orderBy('date')
        .where('blockerId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getAllComment(String _idHistory) {
    return comment
        .orderBy('date', descending: true)
        .where('historyId', isEqualTo: _idHistory)
        .snapshots();
  }

  getAllUserHistory() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getAllUserComment() {
    return comment
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getComment(String _id) {
    return comment.where('id', isEqualTo: _id).get();
  }

  getUser(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getNickName(String _nickname) {
    return user.where('name', isEqualTo: _nickname).get();
  }

  getUsersNickName(String _nickname) {
    return user
        .where('name', arrayContainsAny: ['_nickname'])
        .orderBy('name')
        .snapshots();
  }

  setHistory(Map<String, dynamic> _form) {
    return history.doc(_form['id']).set(_form);
  }

  setUser(Map<String, dynamic> _form) {
    return user.doc(currentUser.value.first.id).set(_form);
  }

  upBookmarks() {
    return bookmark
        .doc(currentUser.value.first.id)
        .update({'historyId': currentBookmarks.value});
  }

  upNicknameHistory(String _id) {
    return history.doc(_id).update({'userName': currentUser.value.first.name});
  }

  upStatusUser(String _status) {
    return user.doc(currentUser.value.first.id).update({'status': _status});
  }

  upToken(String _status) {
    return user.doc(currentUser.value.first.id).update({'status': _status});
  }

  upNicknameComment(String _id) {
    return comment.doc(_id).update({'userName': currentUser.value.first.name});
  }

  upStatusUserComment(String _id) {
    return comment.doc(_id).update({'userStatus': UserStatus.DELETED.name});
  }

  upNotification(String _idNotification) {
    return notification.doc(_idNotification).update({'view': true});
  }

  deleteComment() {
    return comment
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  deleteHistory(String _idHistory) {
    return history.doc(_idHistory).delete();
  }

  deleteUser(String _idUser) {
    return user.doc(_idUser).delete();
  }

  deleteBlock(String blocked) {
    return block.doc(blocked).delete();
  }

  upNickName() {
    return user.doc(currentUser.value.first.id).update({
      'name': currentUser.value.first.name,
      'upDateName': currentUser.value.first.upDateName
    });
  }

  toggleNotification() {
    return user
        .doc(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }

  setUpQtyCommentUser() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyComment': currentUser.value.first.qtyComment});
  }
}
