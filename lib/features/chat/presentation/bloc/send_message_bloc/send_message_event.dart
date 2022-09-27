abstract class SendMessageEvent {}

class EmittingLoadedSendMessageStateEvent extends SendMessageEvent {
  String senderUserUid;
  String receivingUserUid;
  String senderName;
  String receiverName;

  EmittingLoadedSendMessageStateEvent(
      {required this.receivingUserUid,
      required this.senderName,
      required this.senderUserUid,
      required this.receiverName});
}

class SendMessageEventImpl extends SendMessageEvent {
  String senderUserUid;
  String receivingUserUid;
  String message;
  String senderName;
  String receiverName;

  String docId;
  SendMessageEventImpl({
    required this.docId,
    required this.message,
    required this.receiverName,
    required this.receivingUserUid,
    required this.senderName,
    required this.senderUserUid,
  });
}
