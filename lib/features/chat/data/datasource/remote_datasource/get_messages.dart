import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetMessagesSource {
  Stream<QuerySnapshot> getMessagesSource(String docId);
}

class GetMessagesImpl implements GetMessagesSource {
  @override
  Stream<QuerySnapshot> getMessagesSource(String docId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .orderBy("dateTime", descending: false)
        .snapshots();
  }
}
