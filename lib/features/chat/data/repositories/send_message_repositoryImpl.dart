import '../../domain/repository/send_message_repository.dart';
import '../datasource/remote_datasource/send_message.dart';

class SendMessageRepositoryImpl implements SendMessageRepository {
  final SendMessageSource sendMessageSource;

  SendMessageRepositoryImpl({required this.sendMessageSource});

  @override
  void sendMessageRepository(
      String docId,
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      List<String> uidList) {
    sendMessageSource.sendMessageSource(
        senderUserUid: senderUserUid,
        receivingUserUid: receivingUserUid,
        message: message,
        senderName: senderName,
        receiverName: receiverName,
        docId: docId,
        uidList: uidList);
  }
}
