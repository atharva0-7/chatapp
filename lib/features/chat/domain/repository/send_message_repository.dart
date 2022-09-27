abstract class SendMessageRepository {
  void sendMessageRepository(
      String docId,
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      List<String> uidList);
}
