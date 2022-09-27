import 'dart:ffi';

class MessageEntity {
  String message;
  String sentBy;
  int dateTime;
  MessageEntity(
      {required this.message, required this.sentBy, required this.dateTime});
}
