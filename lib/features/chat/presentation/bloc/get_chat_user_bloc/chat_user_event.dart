import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ChatUserEvent {}

class GetChatUserEvent extends ChatUserEvent {
  String uid;
  GetChatUserEvent(this.uid);
}
