import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SendMessageState {}

class SendMessageInitialState extends SendMessageState {}

class SendMessageLoadedState extends SendMessageState {
  Stream<QuerySnapshot> messageList;
  var docid;
  SendMessageLoadedState({required this.messageList, required this.docid});
}
