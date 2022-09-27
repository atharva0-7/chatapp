import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetMessagesSource {
  Stream<QuerySnapshot> getMessagesSource(String docId);
}

class GetMessagesImpl extends GetMessagesSource {
  Stream<QuerySnapshot> getMessagesImpl(String docId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .collection('messages')
        .orderBy("dateTime", descending: false)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot> getMessagesSource(String docId) {
    return getMessagesImpl(docId);
  }
}
