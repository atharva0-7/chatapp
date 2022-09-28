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
  List<Widget> pages = [
    const ChatHomeScreen(),
    const SettingsScreen(),
    const SettingsScreen()
  ];
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
          currentIndex: selectedIndex,
          selectedLabelStyle: kSelectedLabelStyle,
          items: [
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/chatIcon.svg",
                  color: Theme.of(context).primaryColor,
                ),
                label: "Chats".tr,
                icon: SvgPicture.asset("assets/chatIcon.svg")),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/bottomnavigationFriendsIcon.svg",
                  color: Theme.of(context).primaryColor,
                ),
                label: "Friends".tr,
                icon:
                    SvgPicture.asset("assets/bottomnavigationFriendsIcon.svg")),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  "assets/settingLogo.svg",
                  color: Theme.of(context).primaryColor,
                ),
                label: "Settings".tr,
                icon: SvgPicture.asset("assets/settingLogo.svg"))
          ]),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
    );
  }
}
