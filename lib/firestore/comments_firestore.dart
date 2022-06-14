import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsFirestore {
  CollectionReference db = FirebaseFirestore.instance.collection('comments');
}
