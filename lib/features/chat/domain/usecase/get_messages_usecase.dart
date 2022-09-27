import 'package:chat_app_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_messages_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessageUseCase {
  GetMessageRepository getMessageRepository;
  GetMessageUseCase({required this.getMessageRepository});

  Stream<QuerySnapshot> getMessageUseCase(String docId) {
    return getMessageRepository.getMessagesrepository(docId);
  }
}
