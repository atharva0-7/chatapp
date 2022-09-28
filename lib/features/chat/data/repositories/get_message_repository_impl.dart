import 'package:chat_app_flutter/features/chat/domain/repository/get_messages_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasource/remote_datasource/get_messages.dart';

class GetMessageRepositoryImpl implements GetMessageRepository {
  final GetMessagesSource getMessagesSource;
  GetMessageRepositoryImpl({required this.getMessagesSource});
  @override
  Stream<QuerySnapshot> getMessagesrepository(String docId) {
    return getMessagesSource.getMessagesSource(docId);
  }
}
