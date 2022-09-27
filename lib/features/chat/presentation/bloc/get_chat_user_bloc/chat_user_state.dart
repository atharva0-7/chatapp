import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class ChatUserState {}

class InitialChatUserState extends ChatUserState {}

class LoadedChatUserState extends ChatUserState {
  List<UserEntity> usersList;
  UserEntity currentUserData;
  Set<UserEntity> recentSearchedList;
  LoadedChatUserState(
      {required this.usersList,
      required this.currentUserData,
      required this.recentSearchedList});
}
