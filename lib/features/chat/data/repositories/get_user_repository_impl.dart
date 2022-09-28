import 'package:chat_app_flutter/features/chat/data/models/user_model.dart';

import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';

import '../datasource/remote_datasource/get_chat_users.dart';

class GetChatUsersRepositoryImpl implements GetChatUsersRepository {
  final GetChatUsers getChatUsers;
  GetChatUsersRepositoryImpl({required this.getChatUsers});
  @override
  Future<List<UserModel>> getChatUserRepository() {
    return getChatUsers.getSourceChatUsers();
  }
}
