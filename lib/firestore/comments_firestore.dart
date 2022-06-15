import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/models/comment_model.dart';

class CommentsFirestore {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  deleteComment() {
    return comments
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  getComment(String _id) {
    return comments.where('id', isEqualTo: _id).get();
  }

  postComment(Map<String, dynamic> _comment) {
    return comments.doc(_comment['id']).set(_comment);
  }
}
