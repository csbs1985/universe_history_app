import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/user_model.dart';

class FirestoreDatabaseService {
  CollectionReference justification =
      FirebaseFirestore.instance.collection('justifications');

  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');

  setJustify(Map<String, dynamic> _form) {
    return justification.doc(_form['id']).set(_form);
  }

  getAllUserComment() {
    return comment
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  upNicknameComment(String _id) {
    return comment.doc(_id).update({'userName': currentUser.value.first.name});
  }

  upStatusUserComment(String _id) {
    return comment.doc(_id).update({'userStatus': UserStatus.DELETED.name});
  }
}
