abstract class SendMessageEvent {}

class EmittingLoadedSendMessageStateEvent extends SendMessageEvent {
  final String senderUserUid;
  final String receivingUserUid;
  final String senderName;
  final String receiverName;

  EmittingLoadedSendMessageStateEvent(
      {required this.receivingUserUid,
      required this.senderName,
      required this.senderUserUid,
      required this.receiverName});
}

class SendMessageEventImpl extends SendMessageEvent {
  final String senderUserUid;
  final String receivingUserUid;
  final String message;
  final String senderName;
  final String receiverName;

  final String docId;
  SendMessageEventImpl({
    required this.docId,
    required this.message,
    required this.receiverName,
    required this.receivingUserUid,
    required this.senderName,
    required this.senderUserUid,
  });
}
