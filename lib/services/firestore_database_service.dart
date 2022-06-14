import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/user_model.dart';

class FirestoreDatabaseService {
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

  deleteComment() {
    return comment
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  deleteBlock(String blocked) {
    return block.doc(blocked).delete();
  }
}
