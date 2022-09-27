import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/di/injector_config.dart';
import 'package:chat_app_flutter/features/chat/data/models/message_model.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/message_entity.dart';

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

  IndividualChatScreen(
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
  var docid = "";

  final TextEditingController messageController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 200));
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // getUidList();
    // scrollDown();

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
              return const Center(child: CircularProgressIndicator());
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
                                  // reverse: true,
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
                                                  right: 16.0, top: 10)
                                              : const EdgeInsets.only(
                                                  left: 16.0, top: 10),
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
                                            height: 44,
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
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: kTextFieldColor,
                                        borderRadius: BorderRadius.circular(71),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, bottom: 3),
                                        child: TextField(
                                          controller: messageController,
                                          decoration: InputDecoration(
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
                                            scrollDown();
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
// StreamBuilder(
//         stream: messagesStream(currentUserName, receivingUser.name),
//         builder: (context, AsyncSnapshot snapshot) {
//           return Scaffold(
//             body: Stack(
//               children: <Widget>[
//                 Column(children: [
//                   SizedBox(
//                     height: 100,
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Row(
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: kBackIcon),
//                           const CircleAvatar(),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 18.0),
//                             child: Text(
//                               receivingUser.name,
//                               style: kUserChatTitleStyle,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 10.0, right: 10),
//                     child: Divider(),
//                   ),
//                   BlocBuilder<MessageBloc, MessageState>(
//                       builder: (context, state) {
//                     if (state is InitialMessageState) {
//                       BlocProvider.of<MessageBloc>(context).add(GetMessagesData(
//                           currentUserName: currentUserName,
//                           receivierUserName: receivingUser.name));
//                       return const CircularProgressIndicator();
//                     } else if (state is LoadedMessageState) {
//                       return Container(
//                           height: MediaQuery.of(context).size.height - 195,
//                           color: Colors.blue,
//                           child: ListView.builder(
//                             itemCount: state.currentUsersMessages.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: Text(
//                                     state.currentUsersMessages[index]["name"]),
//                                 subtitle: Text(state.currentUsersMessages[index]
//                                     ["message"]),
//                               );
//                             },
//                           ));
//                     } else {
//                       return Container();
//                     }
//                   })
//                 ]),
//                 Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Row(
//                       children: <Widget>[
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all()),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0),
//                               child: TextField(
//                                 onChanged: (value) {
//                                   messageController.text = value;
//                                 },
//                                 decoration: const InputDecoration(
//                                     hintText: "Send message...",
//                                     hintStyle: kHintTextStyle,
//                                     border: InputBorder.none),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ElevatedButton(
//                               onPressed: () async {
//                                 await sendMessage(currentUserName,
//                                     messageController.text, receivingUser.name);
//                                 BlocProvider.of<MessageBloc>(context).add(
//                                     GetMessagesData(
//                                         currentUserName: currentUserName,
//                                         receivierUserName: receivingUser.name));
//                               },
//                               child: kSendMessage),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });

        // StreamBuilder(
        //               stream: state.messageList,
        //               builder:
        //                   (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //                 if (!snapshot.hasData) {
        //                   return const Center(
        //                     child: CircularProgressIndicator(),
        //                   );
        //                 } else {
        //                   return ListView(
        //                     children: snapshot.data!.docs.map((e) {
        //                       print(e['message']);
        //                       return ListTile(
        //                         title: Text(e['message']),
        //                       );
        //                     }).toList(),
        //                   );
        //                 }
        //               },
        //             )

                    