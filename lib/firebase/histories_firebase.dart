import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';

class HistoriesFirestore {
  CollectionReference db = FirebaseFirestore.instance.collection('histories');

  postHistory(Map<String, dynamic> _history) {
    return db.doc(_history['id']).set(_history);
  }

  ////////////////
  getAllUserHistory() {
    return db
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  upNicknameHistory(String _id) {
    return db.doc(_id).update({'userName': currentUser.value.first.name});
  }

  deleteHistory(String _idHistory) {
    return db.doc(_idHistory).delete();
  }
}
