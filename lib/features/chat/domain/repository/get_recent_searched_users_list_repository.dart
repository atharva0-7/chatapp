import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class GetRecentSearchedUsersRepository {
  Future<List<UserEntity>> getRecentSearchedUsersRepository();
}
