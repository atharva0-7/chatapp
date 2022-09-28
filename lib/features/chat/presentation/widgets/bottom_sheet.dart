import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../constants/text_constant.dart';
import '../screen/individual_chat_screen.dart';

showModelBottomSheetFunc(BuildContext context, state, currentUser) {
  return state.usersList.isEmpty
      ? showModalBottomSheet(
          context: context,
          builder: ((context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 16),
                      child: Text(
                        kChatUsersText,
                        style: kChatsTitleTextStyle.copyWith(fontSize: 16),
                      )),
                  Text(kNoUsersFoundText)
                ]),
              ),
            );
          }))
      : showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 16),
                          child: Center(
                            child: Text(
                              kChatUsersText,
                              style:
                                  kChatsTitleTextStyle.copyWith(fontSize: 16),
                            ),
                          )),
                      ...state.usersList.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => IndividualChatScreen(
                                            receivingUser: e,
                                            senderUser: currentUser,
                                            currentUserFirstName:
                                                state.currentUserData.firstName,
                                            currentUserLastName:
                                                state.currentUserData.lastName,
                                          )));
                            },
                            child: Column(
                              children: [
                                state.currentUserData.phoneNumber ==
                                        e.phoneNumber
                                    ? Container()
                                    : ListTile(
                                        subtitle: Text(e.phoneNumber,
                                            style: kChatUsersSubTitleTextStyle),
                                        title: Text(
                                          "${e.firstName} ${e.lastName}",
                                          style: kChatUsersTextStyle,
                                        ),
                                      ),
                                state.currentUserData.phoneNumber ==
                                        e.phoneNumber
                                    ? const Divider()
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ]),
              ),
            );
          },
        );
}
