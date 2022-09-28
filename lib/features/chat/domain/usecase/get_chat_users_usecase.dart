import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';

class GetChatUsersUseCase {
  GetChatUsersRepository getChatUsersRepository;
  GetChatUsersUseCase({required this.getChatUsersRepository});

  Future<List<UserEntity>> getChatUsersUseCase() {
    return getChatUsersRepository.getChatUserRepository();
  }
}
