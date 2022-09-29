import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChatEntity {
  UserEntity userEntity;
  Stream<QuerySnapshot<Map<String, dynamic>>> latestMessage;
  RecentChatEntity({required this.latestMessage, required this.userEntity});
}
