import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_state.dart';
import 'package:chat_app_flutter/features/chat/presentation/widgets/alert_dialogue.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/text_constant.dart';
import '../bloc/get_chat_user_bloc/chat_user_event.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final User currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatUserBloc, ChatUserState>(
        builder: (context, state) {
          if (state is InitialChatUserState) {
            BlocProvider.of<ChatUserBloc>(context)
                .add(GetChatUserEvent(currentUser.uid));
          } else if (state is LoadedChatUserState) {
            return Padding(
              padding: EdgeInsets.only(top: 60.0.h, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      kSettingsTitleText,
                      style: kSettingsTitleTextStyle,
                    ),
                    SizedBox(height: 27.5.h),
                    SvgPicture.asset("assets/Avatar.svg"),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      "${state.currentUserData.firstName} ${state.currentUserData.lastName}",
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 16.sp),
                    ),
                    SizedBox(height: 48.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kSavedMesssageText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kRecentCallsText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kDevicesText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kNotificationText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kAppearanceText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  kLanguageString,
                                  style: kSettingsPageOptionTextStyle,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(kPrivacyText),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kStorageText,
                                style: kSettingsPageOptionTextStyle,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap: () => showDialogueFunction(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  kLogOutText,
                                  style: kSettingsPageOptionTextStyle,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
