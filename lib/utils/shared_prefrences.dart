import 'dart:convert';

import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String sharedPreferenceUserLoggedInKey = 'USERLOGGEDINKEY';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailnKey = 'USEREMAILKEY';
  static String sharedPreferenceUserPhoneKey = 'USERPHONEKEY';

  static String sharedPreferenceRecentSearched = "RECENTSEARCHEDUSERS";

  static Future saveUserLoggedInSharedPreferences(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isLoggedIn);
  }

  static Future saveUserNameSharedPreferences(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future saveUserEmailSharedPreferences(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, email);
  }

  static Future saveUserPhoneSharedPreferences(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, phone);
  }

  static Future saveRecentSearchedUsers(
      List<UserEntity> recentSearchedList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(json.encode(recentSearchedList));
    return await prefs.setString(
        sharedPreferenceRecentSearched, json.encode(recentSearchedList));
  }

  static Future getRecentSearchedUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(sharedPreferenceRecentSearched);
  }

  static Future getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future getUserEmailSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailnKey);
  }

  static Future getUserNameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future getUserPhoneSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserPhoneKey);
  }
}
