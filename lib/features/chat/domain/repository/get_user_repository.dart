import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class GetChatUsersRepository {
  Future<List<UserEntity>> getChatUserRepository();
}
