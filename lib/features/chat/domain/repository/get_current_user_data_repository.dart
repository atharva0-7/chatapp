import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class GetCurrentUserDataRepository {
  Future<UserEntity> getCurrentUserDataRepository(String uid);
}
