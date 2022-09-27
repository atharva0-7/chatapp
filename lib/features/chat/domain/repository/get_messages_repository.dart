import 'package:chat_app_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetMessageRepository {
  Stream<QuerySnapshot> getMessagesrepository(String docId);
}
