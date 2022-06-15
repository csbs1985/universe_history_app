import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';

class BlockedsFirestore {
  CollectionReference blockeds =
      FirebaseFirestore.instance.collection('blockeds');

  deleteBlock(String blocked) {
    return blockeds.doc(blocked).delete();
  }

  getAllBlock() {
    return blockeds
        .orderBy('date')
        .where('blockerId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  postBlock(Map<String, dynamic> _form) {
    return blockeds.doc(_form['id']).set(_form);
  }
}
