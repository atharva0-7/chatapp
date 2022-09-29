import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';

import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_event.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_state.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/individual_chat_screen.dart';

import 'package:chat_app_flutter/features/chat/presentation/screen/search_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constant.dart';

List<UserEntity> recentChatList = [];

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController messageController = TextEditingController();
  Set<UserEntity> sharedPrefTempList = {};
  // late var sharedPrefRecentSearchedUsers;
  // clearData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.clear();
  // }

  Future<void> callingSetState() {
    return Future.delayed(Duration(seconds: 1)).whenComplete(
      () {
        BlocProvider.of<ChatUserBloc>(context)
            .add(GetChatUserEvent(currentUser.uid));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // clearData();
    // print(searchedUsersList);
    return BlocBuilder<ChatUserBloc, ChatUserState>(
      builder: (context, state) {
        if (state is InitialChatUserState) {
          BlocProvider.of<ChatUserBloc>(context)
              .add(GetChatUserEvent(currentUser.uid));
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 24.0.w, right: 24.w, top: 24.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kLeadingEditText,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          kChatsTitleText,
                          style: kChatsTitleTextStyle,
                        ),
                        SvgPicture.asset("assets/editIcon.svg"),
                      ],
                    ),
                    SizedBox(
                      height: 19.5.h,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                          ),
                          isDense: true,
                          constraints: const BoxConstraints(),
                          hintText: "Search".tr,
                          hintStyle: const TextStyle(
                              color: kNotAMemberColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24))),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is LoadedChatUserState) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 24.0.w, right: 24.w, top: 24.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          kLeadingEditText,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          kChatsTitleText,
                          style: kChatsTitleTextStyle,
                        ),
                        GestureDetector(
                            onTap: () {
                              BlocProvider.of<ChatUserBloc>(context)
                                  .add(GetChatUserEvent(currentUser.uid));

                              showModelBottomSheetFunc(
                                  context, state, currentUser);
                            },
                            child: SvgPicture.asset("assets/editIcon.svg")),
                      ],
                    ),
                    SizedBox(
                      height: 19.5.h,
                    ),
                    TextField(
                      controller: messageController,
                      onChanged: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchScreen(
                                    currentuserData: state.currentUserData,
                                    allUsersList: state.usersList,
                                    recentSearchedList:
                                        state.recentSearchedList)));
                        messageController.text = "";
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchScreen(
                                    currentuserData: state.currentUserData,
                                    allUsersList: state.usersList,
                                    recentSearchedList:
                                        state.recentSearchedList)));
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                          ),
                          isDense: true,
                          constraints: const BoxConstraints(),
                          hintText: "Search".tr,
                          hintStyle: const TextStyle(
                              color: kNotAMemberColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24))),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () {
                        return callingSetState();
                      },
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: state.recentChatList.map((e) {
                          // Map messageMap = e.latestMessage[0].data() as Map;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => IndividualChatScreen(
                                          receivingUser: e.userEntity,
                                          senderUser: currentUser,
                                          currentUserLastName:
                                              state.currentUserData.lastName,
                                          currentUserFirstName: state
                                              .currentUserData.firstName)));
                            },
                            child: StreamBuilder(
                                stream: e.latestMessage,
                                builder: (context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    var querySnapshot = snapshot.data;
                                    return ListTile(
                                      subtitle: Text(
                                          snapshot.data!.docs[0]['message']),
                                      title: Text(
                                        "${e.userEntity.firstName} ${e.userEntity.lastName}",
                                        style: kChatsTitleTextStyle.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                }),
                          );
                        }).toList(),
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
