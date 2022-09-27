import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SendMessageSource {
  sendMessageSource(
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      String docId,
      List<String> uidList);
}

class SendMessageSourceImpl extends SendMessageSource {
  @override
  sendMessageSource(
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      String docId,
      List<String> uidList) {
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
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
        await firebaseFirestore
            .collection('chats')
            .doc(docId)
            .set({"user1": senderName, "user2": receiverName, "uid": docId});
      }
    } catch (e) {
      print(e);
    }
  }
}
