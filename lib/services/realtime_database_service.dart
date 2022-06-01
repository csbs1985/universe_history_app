// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:firebase_database/firebase_database.dart';
import 'package:universe_history_app/models/user_model.dart';

class RealtimeDatabaseService {
  DatabaseReference histories = FirebaseDatabase.instance.ref('histories');
  DatabaseReference users = FirebaseDatabase.instance.ref('users');

  getUserEmail(String _email) async {
    return await users.orderByChild('email').equalTo(_email).get();
  }

  getUserName(String _name) async {
    return await users.orderByChild('name').equalTo(_name).get();
  }

  postNewUser(UserModel user) {
    users.push().child(user.id).set({
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
    }).asStream();
  }

  /////////////////////////

  getAll() async {
    // busca tudo
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot}'); // DataSnapshot
    });
  }

  get() async {
    // busca
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    Query query = ref
        .orderByChild("age")
        .limitToFirst(10)
        .startAt(18)
        .endAt(30)
        .equalTo('value');
    DataSnapshot event = await query.get();
    print(event);
  }

  put() async {
    // atualiza
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }

  patch() async {
    // atualiza partes
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    await ref.update({"age": 19});
  }

  delete() async {
    // deleta
    DatabaseReference ref = FirebaseDatabase.instance.ref("users");
    await ref.remove();
  }
}
