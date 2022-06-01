// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';

class RealtimeDatabaseService {
  DatabaseReference histories = FirebaseDatabase.instance.ref('histories');
  DatabaseReference users = FirebaseDatabase.instance.ref('users');

  Future<String?> token = FirebaseMessaging.instance.getToken();

  getUserEmail(String _email) async {
    return await users.orderByChild('email').equalTo(_email).get();
  }

  getUserName(String _name) async {
    return await users.orderByChild('name').equalTo(_name).get();
  }

  getToken() {
    return token;
  }

  pathLogout(String user, String token, String status) async {
    await users.child(user).update({
      "status": status,
      "token": token,
    });
  }

  pathQtyHistoryUser(String _user) async {
    await users
        .child(_user)
        .update({"qtyHistory": currentUser.value.first.qtyHistory});
  }

  pathToken(_user, {String? token}) async {
    await users.child(_user).update({"token": token ?? ''});
  }

  postNewUser(UserModel _user) {
    users.child(_user.id).set({
      'date': _user.date,
      'email': _user.email,
      'id': _user.id,
      'isNotification': _user.isNotification,
      'name': _user.name,
      'qtyComment': _user.qtyComment,
      'qtyHistory': _user.qtyHistory,
      'status': _user.status,
      'token': _user.token,
      'upDateName': _user.upDateName,
    });
  }

  postNewHistory(HistoryModel _history) {
    histories.child(_history.id).set({
      'id': _history.id,
      'title': _history.title,
      'text': _history.text,
      'date': _history.date,
      'isComment': _history.isComment,
      'isSigned': _history.isSigned,
      'isEdit': _history.isEdit,
      'isAuthorized': _history.isAuthorized,
      'qtyComment': _history.qtyComment,
      'categories': _history.categories,
      'userId': _history.userId,
      'userName': _history.userName,
      'bookmarks': _history.bookmarks,
    });
  }
}
