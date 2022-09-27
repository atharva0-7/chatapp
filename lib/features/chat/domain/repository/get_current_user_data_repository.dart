import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetCurrentUserDataRepository {
  Future<UserEntity> getCurrentUserDataRepository(String uid);
}
