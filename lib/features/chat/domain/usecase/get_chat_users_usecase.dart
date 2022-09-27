import 'package:chat_app_flutter/features/chat/data/datasource/remote/get_chat_users.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetChatUsersUseCase {
  GetChatUsersRepository getChatUsersRepository;
  GetChatUsersUseCase({required this.getChatUsersRepository});

  Future<List<UserEntity>> getChatUsersUseCase() {
    return getChatUsersRepository.getChatUserRepository();
  }
}
