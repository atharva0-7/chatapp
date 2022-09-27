import 'package:chat_app_flutter/features/chat/data/datasource/remote/get_messages.dart';
import 'package:chat_app_flutter/features/chat/data/datasource/remote/send_message.dart';
import 'package:chat_app_flutter/features/chat/data/models/message_model.dart';

import '../../domain/repository/send_message_repository.dart';

class SendMessageRepositoryImpl extends SendMessageRepository {
  SendMessageSource sendMessageSource;


  SendMessageRepositoryImpl(
      {required this.sendMessageSource});

  @override
  void sendMessageRepository(
      String docId,
      String senderUserUid,
      String receivingUserUid,
      String message,
      String senderName,
      String receiverName,
      List<String> uidList) {
    sendMessageSource.sendMessageSource(senderUserUid, receivingUserUid,
        message, senderName, receiverName, docId, uidList);
  }
}
