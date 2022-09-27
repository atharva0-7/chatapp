import 'dart:ffi';

import 'package:chat_app_flutter/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/get_messages_usecase.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_event.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/send_message_usecase.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageUseCase sendMessageUseCase;
  GetMessageUseCase getMessageUseCase;
  List<String> uidList = [];
  late Stream chatMessageStream;
  var docId = "";
  SendMessageBloc(
      {required this.sendMessageUseCase, required this.getMessageUseCase})
      : super(SendMessageInitialState()) {
    on<EmittingLoadedSendMessageStateEvent>((event, emit) async {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('chats').get();
      uidList = snapshot.docs.map((e) => e.id).toList();

      if (!uidList.contains(event.senderUserUid + event.receivingUserUid)) {
        if (uidList.contains(event.receivingUserUid + event.senderUserUid)) {
          print(uidList);

          docId = event.receivingUserUid + event.senderUserUid;
        } else {
          docId = event.senderUserUid + event.receivingUserUid;
        }
      } else {
        docId = event.senderUserUid + event.receivingUserUid;
      }
      Stream<QuerySnapshot> messageList =
          await getMessageUseCase.getMessageUseCase(docId);
      emit(SendMessageLoadedState(messageList: messageList, docid: docId));
    });

    on<SendMessageEventImpl>((event, emit) async {
      sendMessageUseCase.sendMessageUseCase(
          docId: docId,
          senderUserUid: event.senderUserUid,
          receivingUserUid: event.receivingUserUid,
          message: event.message,
          senderName: event.senderName,
          receiverName: event.receiverName,
          uidList: uidList);
      Stream<QuerySnapshot> messageList =
          getMessageUseCase.getMessageUseCase(docId);
      emit(SendMessageLoadedState(messageList: messageList, docid: docId));
    });
  }
}
