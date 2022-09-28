import 'package:chat_app_flutter/constants/color_constant.dart';
import 'package:chat_app_flutter/di/injector_config.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_state.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/individual_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants/text_constant.dart';
import '../../../../constants/text_style.dart';
import '../../../../utils/shared_prefrences.dart';
import '../bloc/get_chat_user_bloc/chat_user_event.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {Key? key,
      required this.recentSearchedList,
      required this.allUsersList,
      required this.currentuserData})
      : super(key: key);
  final List<UserEntity> recentSearchedList;
  final List<UserEntity> allUsersList;
  final UserEntity currentuserData;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  List<UserEntity> searchedUsersList = [];

  @override
  Widget build(BuildContext context) {
    print(widget.recentSearchedList);
    return BlocProvider(
      create: (context) => InjectorConfig.resolve<ChatUserBloc>(),
      child: Scaffold(
        body: BlocBuilder<ChatUserBloc, ChatUserState>(
          builder: (context, state) {
            if (state is InitialChatUserState) {
              BlocProvider.of<ChatUserBloc>(context)
                  .add(GetChatUserEvent(user.uid));
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedChatUserState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      autofocus: true,
                      onChanged: searchUsers,
                      decoration: InputDecoration(
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: SizedBox(
                        child: widget.recentSearchedList.isEmpty ||
                                searchedUsersList.isNotEmpty
                            ? Text(
                                kSearchUsersText,
                                style: kRecentSearchTextStyle,
                              )
                            : Text(
                                kRecentSearchText,
                                style: kRecentSearchTextStyle,
                              ),
                      ),
                    ),
                    widget.recentSearchedList.isEmpty ||
                            searchedUsersList.isNotEmpty
                        ? Expanded(
                            child: ListView(
                              padding: EdgeInsets.only(top: 32.h),
                              children: searchedUsersList.map((e) {
                                return widget.currentuserData.phoneNumber ==
                                        e.phoneNumber
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          print(searchedUsersList);
                                          if (!widget.recentSearchedList
                                              .contains(e)) {
                                            state.recentSearchedList.add(e);
                                            SharedPref
                                                    .saveRecentSearchedUsers(state
                                                        .recentSearchedList)
                                                .then((value) => Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => IndividualChatScreen(
                                                            receivingUser: e,
                                                            senderUser: user,
                                                            currentUserLastName:
                                                                widget
                                                                    .currentuserData
                                                                    .lastName,
                                                            currentUserFirstName: widget
                                                                .currentuserData
                                                                .firstName))));
                                          } else {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => IndividualChatScreen(
                                                        receivingUser: e,
                                                        senderUser: user,
                                                        currentUserLastName:
                                                            widget
                                                                .currentuserData
                                                                .lastName,
                                                        currentUserFirstName:
                                                            widget
                                                                .currentuserData
                                                                .firstName)));
                                          }
                                        },
                                        child: ListTile(
                                          title: Text(
                                              "${e.firstName} ${e.lastName}"),
                                        ),
                                      );
                              }).toList(),
                            ),
                          )
                        : Expanded(
                            child: ListView(
                              padding: EdgeInsets.only(top: 32.h, left: 16.w),
                              children: widget.recentSearchedList.map((e) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                IndividualChatScreen(
                                                    receivingUser: e,
                                                    senderUser: user,
                                                    currentUserLastName: widget
                                                        .currentuserData
                                                        .lastName,
                                                    currentUserFirstName: widget
                                                        .currentuserData
                                                        .firstName)));
                                  },
                                  child: ListTile(
                                    trailing: SvgPicture.asset(
                                        "assets/cancelIcon.svg"),
                                    title: Text("${e.firstName} ${e.lastName}"),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  void searchUsers(String query) {
    if (query == "") {
      setState(() {
        searchedUsersList = [];
      });
      Navigator.pop(context);
      return;
    }
    List<UserEntity> tempList = widget.allUsersList;
    List<UserEntity> suggestion = tempList.where((element) {
      final userFirstName = element.firstName.toString().toLowerCase();
      final userLastName = element.lastName.toString().toLowerCase();
      final input = query.trimLeft().trimRight().toLowerCase();
      return userFirstName.startsWith(input) || userLastName.startsWith(input);
    }).toList();
    setState(() {
      searchedUsersList = suggestion;
    });
  }
}
