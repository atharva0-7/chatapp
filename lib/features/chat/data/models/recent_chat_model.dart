import 'dart:convert';

import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChatModel extends RecentChatEntity {
  RecentChatModel(
      {required Stream<QuerySnapshot<Map<String, dynamic>>> latestMessage,
      required UserEntity userEntity})
      : super(latestMessage: latestMessage, userEntity: userEntity);
  factory RecentChatModel.fromRawJson(String str) =>
      RecentChatModel.fromJson(json.decode(str));

  factory RecentChatModel.fromJson(json) {
    return RecentChatModel(
        latestMessage: json["latestMessage"],
        userEntity: json["receivingUser"]);
  }
}
