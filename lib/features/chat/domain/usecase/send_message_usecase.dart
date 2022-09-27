import 'package:chat_app_flutter/features/chat/domain/repository/send_message_repository.dart';

class SendMessageUseCase {
  SendMessageRepository sendMessageRepository;
  SendMessageUseCase({required this.sendMessageRepository});

  sendMessageUseCase(
      {required String docId,
      required String senderUserUid,
      required String receivingUserUid,
      required String message,
      required String senderName,
      required String receiverName,
      required List<String> uidList}) {
    sendMessageRepository.sendMessageRepository(docId, senderUserUid,
        receivingUserUid, message, senderName, receiverName, uidList);
  }
}
