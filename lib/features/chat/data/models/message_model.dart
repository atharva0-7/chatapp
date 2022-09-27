import 'dart:convert';

import 'package:chat_app_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required String message, required String sentBy, required int dateTime})
      : super(message: message, sentBy: sentBy, dateTime: dateTime);
  factory MessageModel.fromRawJson(String str) =>
      MessageModel.fromJson(json.decode(str));

  factory MessageModel.fromJson(QueryDocumentSnapshot<Object?> json) {
    return MessageModel(
        message: json["message"],
        sentBy: json["sentBy"],
        dateTime: json["dateTime"]);
  }
}
