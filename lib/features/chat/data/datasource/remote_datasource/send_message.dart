import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SendMessageSource {
  sendMessageSource(
      {required String senderUserUid,
      required String receivingUserUid,
      required String message,
      required String senderName,
      required String receiverName,
      required String docId,
      required List<String> uidList});
}

class SendMessageSourceImpl implements SendMessageSource {
  @override
  sendMessageSource(
      {required String senderUserUid,
      required String receivingUserUid,
      required String message,
      required String senderName,
      required String receiverName,
      required String docId,
      required List<String> uidList}) {
    sendMessage(senderUserUid, receivingUserUid, message, senderName,
        receiverName, docId, uidList);
  }

  void sendMessage(
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      String docId,
      List<String> uidList) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      await firebaseFirestore
          .collection("chats")
          .doc(docId)
          .collection("messages")
          .add({
        "dateTime": DateTime.now().microsecondsSinceEpoch,
        "message": message,
        "sentBy": senderName
      });
      if (!uidList.contains(docId)) {
        await firebaseFirestore.collection('chats').doc(docId).set({
          "user1": senderName,
          "user2": receiverName,
          "uid": docId,
          "uid1": senderUserUid,
          "uid2": receivingUserUid
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
