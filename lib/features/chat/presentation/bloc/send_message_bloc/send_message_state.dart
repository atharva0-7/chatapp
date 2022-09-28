import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SendMessageState {}

class SendMessageInitialState implements SendMessageState {}

class SendMessageLoadedState implements SendMessageState {
  final Stream<QuerySnapshot> messageList;
  final String docid;
  SendMessageLoadedState({required this.messageList, required this.docid});
}
