import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class ChatUserState {}

class InitialChatUserState implements ChatUserState {}

class LoadedChatUserState implements ChatUserState {
  final List<UserEntity> usersList;
  final List<RecentChatEntity> recentChatList;
  final UserEntity currentUserData;
  final List<UserEntity> recentSearchedList;
  LoadedChatUserState(
      {required this.recentChatList,
      required this.usersList,
      required this.currentUserData,
      required this.recentSearchedList});
}
