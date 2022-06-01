// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  pathToken(_user, {String? token}) async {
    await users.child(_user).update({"token": token ?? ''});
  }

  postNewUser(UserModel user) {
    users.child(user.id).set({
      'date': user.date,
      'email': user.email,
      'id': user.id,
      'isNotification': user.isNotification,
      'name': user.name,
      'qtyComment': user.qtyComment,
      'qtyHistory': user.qtyHistory,
      'status': user.status,
      'token': user.token,
      'upDateName': user.upDateName,
    });
  }
}
