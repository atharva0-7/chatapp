import 'package:chat_app_flutter/constants/text_style.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/chat_home_screen.dart';
import 'package:chat_app_flutter/features/chat/presentation/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  List pages = [ChatHomeScreen(), SettingsScreen(), SettingsScreen()];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          // selectedIconTheme:
          //     IconThemeData(color: Theme.of(context).primaryColor),
          unselectedLabelStyle: kUnSelectedLabelStyle,
          selectedLabelStyle: kSelectedLabelStyle,
          items: [
            BottomNavigationBarItem(
                label: "Chats".tr,
                icon: SvgPicture.asset("assets/chatIcon.svg")),
            BottomNavigationBarItem(
                label: "Friends".tr,
                icon:
                    SvgPicture.asset("assets/bottomnavigationFriendsIcon.svg")),
            BottomNavigationBarItem(
                label: "Settings".tr,
                icon: SvgPicture.asset("assets/settingLogo.svg"))
          ]),
      body: pages.elementAt(selectedIndex),
    );
  }
}
