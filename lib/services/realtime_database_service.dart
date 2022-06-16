// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:firebase_database/firebase_database.dart';
import 'package:universe_history_app/models/user_model.dart';

class RealtimeDatabaseService {
  DatabaseReference comments = FirebaseDatabase.instance.ref('comments');
  DatabaseReference histories = FirebaseDatabase.instance.ref('histories');

  DatabaseReference users = FirebaseDatabase.instance.ref('users');

  getUserEmail(String _email) async {
    return await users.orderByChild('email').equalTo(_email).get();
  }

  getUserName(String _name) async {
    return await users.orderByChild('name').equalTo(_name).get();
  }

  postUserBookmark(_history) {
    return histories
        .child(_history['id'])
        .child('bookmark')
        .set(currentUser.value.first.id);
  }

  pathNotification() {
    return users
        .child(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }
}
