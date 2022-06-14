import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsFirestore {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  getComment(String _id) {
    return comments.where('id', isEqualTo: _id).get();
  }

  postComment(Map<String, dynamic> _comment) {
    return comments.doc(_comment['id']).set(_comment);
  }
}
