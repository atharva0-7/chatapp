import 'package:chat_app_flutter/constants/text_constant.dart';
import 'package:chat_app_flutter/constants/text_style.dart';

import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_event.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_state.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/individual_chat_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/color_constant.dart';
import '../../../../utils/shared_prefrences.dart';

List<UserEntity> recentChatList = [];

class ChatHomeScreen extends StatefulWidget {
  ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  Set<UserEntity> searchedUsersList = {};
  List<UserEntity> allUsersList = [];
  // late var sharedPrefRecentSearchedUsers;
  clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
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
                        kChatsTitleText,
                        SvgPicture.asset("assets/editIcon.svg"),
                      ],
                    ),
                    SizedBox(
                      height: 19.5.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kSearchBarColor,
                          borderRadius: BorderRadius.circular(24)),
                      height: 44,
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                            constraints: const BoxConstraints(),
                            hintText: "Search".tr,
                            hintStyle: TextStyle(
                                color: kNotAMemberColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
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
                        kChatsTitleText,
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
                    Container(
                      decoration: BoxDecoration(
                          color: kSearchBarColor,
                          borderRadius: BorderRadius.circular(24)),
                      height: 44,
                      width: double.infinity,
                      child: TextField(
                        onTap: () {
                          BlocProvider.of<ChatUserBloc>(context)
                              .add(GetChatUserEvent(currentUser.uid));
                          setState(() {
                            print(state.recentSearchedList);
                            searchedUsersList = state.recentSearchedList;
                          });

                          setState(() {
                            allUsersList = state.usersList;
                          });
                        },
                        onChanged: searchUsers,
                        decoration: InputDecoration(
                            constraints: const BoxConstraints(),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: kNotAMemberColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none),
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        searchedUsersList.isEmpty
                            ? const SizedBox()
                            : kSearchUsersText,
                        ...searchedUsersList.map((e) {
                          return e.phoneNumber ==
                                  state.currentUserData.phoneNumber
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    print(state.recentSearchedList);
                                    if (!searchedUsersList.contains(e)) {
                                      recentChatList.add(e);
                                      SharedPref.saveRecentSearchedUsers(
                                          recentChatList);
                                      print(recentChatList);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  IndividualChatScreen(
                                                      receivingUser: e,
                                                      senderUser: currentUser,
                                                      currentUserLastName: state
                                                          .currentUserData
                                                          .lastName,
                                                      currentUserFirstName:
                                                          state.currentUserData
                                                              .firstName)));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  IndividualChatScreen(
                                                      receivingUser: e,
                                                      senderUser: currentUser,
                                                      currentUserLastName: state
                                                          .currentUserData
                                                          .lastName,
                                                      currentUserFirstName:
                                                          state.currentUserData
                                                              .firstName)));
                                    }
                                  },
                                  child: ListTile(
                                    title: Text(
                                      "${e.firstName} ${e.lastName}",
                                      style: kSearchUsersTextStyle,
                                    ),
                                    subtitle: Text(e.phoneNumber),
                                  ),
                                );
                        }).toList(),
                      ]),
                    )
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

  void searchUsers(String query) {
    if (query == "") {
      setState(() {
        searchedUsersList = {};
      });
      return;
    }
    List<UserEntity> tempList = allUsersList;
    Set<UserEntity> suggestion = tempList.where((element) {
      final userFirstName = element.firstName.toString().toLowerCase();
      final userLastName = element.lastName.toString().toLowerCase();
      final input = query.trimLeft().trimRight().toLowerCase();
      return userFirstName.startsWith(input) || userLastName.startsWith(input);
    }).toSet();
    setState(() {
      searchedUsersList = suggestion;
    });
  }
}
