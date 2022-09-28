import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/di/injector_config.dart';
import 'package:chat_app_flutter/features/chat/data/models/message_model.dart';

import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_event.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IndividualChatScreen extends StatefulWidget {
  final UserEntity receivingUser;
  final User senderUser;
  final String currentUserLastName;
  final String currentUserFirstName;

  const IndividualChatScreen(
      {Key? key,
      required this.receivingUser,
      required this.senderUser,
      required this.currentUserLastName,
      required this.currentUserFirstName})
      : super(key: key);

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
//  final String docid = "";

  final TextEditingController messageController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InjectorConfig.resolve<SendMessageBloc>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              )),
          title: Text(
            "${widget.receivingUser.firstName} ${widget.receivingUser.lastName}",
            style: kChatUsersTextStyle.copyWith(color: Colors.black),
          ),
          backgroundColor: kAppBarColor,
        ),
        body: BlocBuilder<SendMessageBloc, SendMessageState>(
          builder: (context, state) {
            if (state is SendMessageInitialState) {
              BlocProvider.of<SendMessageBloc>(context)
                  .add(EmittingLoadedSendMessageStateEvent(
                receiverName:
                    "${widget.receivingUser.firstName} ${widget.receivingUser.lastName}",
                receivingUserUid: widget.receivingUser.uid,
                senderName:
                    "${widget.currentUserFirstName} ${widget.currentUserLastName}",
                senderUserUid: widget.senderUser.uid,
              ));
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: CircularProgressIndicator()),
                  Expanded(child: Column()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 20, top: 5),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Container(
                              // height: 40,
                              decoration: BoxDecoration(
                                color: kTextFieldColor,
                                borderRadius: BorderRadius.circular(71),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, bottom: 3, right: 20),
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 4,
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message...",
                                      hintStyle: kHintTextStyle),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 25,
                              width: 32,
                              child: FloatingActionButton(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  onPressed: () async {
                                    // scrollDown();
                                  },
                                  child:
                                      SvgPicture.asset("assets/sendIcon.svg")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            } else if (state is SendMessageLoadedState) {
              return StreamBuilder(
                  stream: state.messageList,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ListView(
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  reverse: true,
                                  children: [
                                    ...snapshot.data!.docs.map((e) {
                                      MessageModel messageModel =
                                          MessageModel.fromJson(e);
                                      // print(e['message']);
                                      return Align(
                                        alignment: messageModel.sentBy ==
                                                "${widget.currentUserFirstName} ${widget.currentUserLastName}"
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Padding(
                                          padding: messageModel.sentBy ==
                                                  "${widget.currentUserFirstName} ${widget.currentUserLastName}"
                                              ? const EdgeInsets.only(
                                                  right: 16.0,
                                                  top: 10,
                                                  left: 16.0)
                                              : const EdgeInsets.only(
                                                  right: 16.0,
                                                  left: 16.0,
                                                  top: 10),
                                          child: Container(
                                            decoration: messageModel.sentBy ==
                                                    "${widget.currentUserFirstName} ${widget.currentUserLastName}"
                                                ? BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(24),
                                                        topRight:
                                                            Radius.circular(24),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                24)),
                                                    color: Theme.of(context)
                                                        .primaryColor)
                                                : const BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(24),
                                                        topRight:
                                                            Radius.circular(24),
                                                        bottomRight:
                                                            Radius.circular(
                                                                24)),
                                                    color: kReceiveMessageBoxColor),
                                            // height: 44,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 12),
                                              child: Text(messageModel.message,
                                                  style: messageModel.sentBy ==
                                                          "${widget.currentUserFirstName} ${widget.currentUserLastName}"
                                                      ? kSentMessageStyle
                                                      : kReceiveMessageStyle),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    SizedBox(
                                      height: 50.h,
                                    )
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, bottom: 20, top: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 40,
                                      decoration: BoxDecoration(
                                        color: kTextFieldColor,
                                        borderRadius: BorderRadius.circular(71),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 24.0, bottom: 3, right: 20),
                                        child: TextField(
                                          minLines: 1,
                                          maxLines: 4,
                                          controller: messageController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Type a message...",
                                              hintStyle: kHintTextStyle),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 25,
                                      width: 32,
                                      child: FloatingActionButton(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          foregroundColor:
                                              Theme.of(context).primaryColor,
                                          onPressed: () async {
                                            // scrollDown();

                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (messageController.text != " " &&
                                                messageController.text != "") {
                                              BlocProvider.of<SendMessageBloc>(
                                                      context)
                                                  .add(SendMessageEventImpl(
                                                docId: state.docid,
                                                message: messageController.text,
                                                receiverName:
                                                    "${widget.receivingUser.firstName} ${widget.receivingUser.lastName}",
                                                receivingUserUid:
                                                    widget.receivingUser.uid,
                                                senderName:
                                                    "${widget.currentUserFirstName} ${widget.currentUserLastName}",
                                                senderUserUid:
                                                    widget.senderUser.uid,
                                              ));
                                            }
                                            messageController.text = "";
                                          },
                                          child: SvgPicture.asset(
                                              "assets/sendIcon.svg")),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  });
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
