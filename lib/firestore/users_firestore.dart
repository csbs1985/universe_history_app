import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';

class UsersFirestore {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  postUser(Map<String, dynamic> _user) {
    return user.doc(_user['id']).set(_user);
  }

  getUserEmail(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  pathName() {
    return user.doc(currentUser.value.first.id).update({
      'name': currentUser.value.first.name,
      'upDateName': currentUser.value.first.upDateName
    });
  }

  pathQtyCommentUser(UserModel _user) {
    return user.doc(_user.id).update({'qtyComment': _user.qtyComment});
  }

  pathQtyHistoryUser(UserModel _user) async {
    await user.doc(_user.id).update({"qtyHistory": _user.qtyHistory});
  }

  ////////////
  getTokenOwner(String _user) {
    return user.where('id', isEqualTo: _user).get();
  }

  getUser(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getName(String _nickname) {
    return user.where('name', isEqualTo: _nickname).get();
  }

  deleteUser(String _idUser) {
    return user.doc(_idUser).delete();
  }
}
