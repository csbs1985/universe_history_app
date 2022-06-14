import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';

class HistoriesFirestore {
  CollectionReference histories =
      FirebaseFirestore.instance.collection('histories');

  geHistory(String _idHistory) {
    return histories.where('id', isEqualTo: _idHistory).snapshots();
  }

  postHistory(Map<String, dynamic> _history) {
    return histories.doc(_history['id']).set(_history);
  }

  pathQtyCommentHistory(HistoryModel _history) {
    return histories
        .doc(_history.id)
        .update({'qtyComment': _history.qtyComment});
  }

  pathBookmark(Map<String, dynamic> _history) {
    return histories
        .doc(_history['id'])
        .update({'bookmarks': _history['bookmarks']});
  }

  ////////////////
  getAllUserHistory() {
    return histories
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  upNicknameHistory(String _id) {
    return histories
        .doc(_id)
        .update({'userName': currentUser.value.first.name});
  }

  deleteHistory(String _idHistory) {
    return histories.doc(_idHistory).delete();
  }
}
