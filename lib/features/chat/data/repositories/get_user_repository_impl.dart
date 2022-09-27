import 'package:chat_app_flutter/features/chat/data/datasource/remote/get_chat_users.dart';
import 'package:chat_app_flutter/features/chat/data/models/user_model.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetChatUsersRepositoryImpl extends GetChatUsersRepository {
  GetChatUsers getChatUsers;
  GetChatUsersRepositoryImpl({required this.getChatUsers});
  @override
  Future<List<UserModel>> getChatUserRepository() {
    return getChatUsers.getSourceChatUsers();
  }
}
