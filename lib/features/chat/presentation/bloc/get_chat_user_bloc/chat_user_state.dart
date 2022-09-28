import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class ChatUserState {}

class InitialChatUserState implements ChatUserState {}

class LoadedChatUserState implements ChatUserState {
  final List<UserEntity> usersList;
  final UserEntity currentUserData;
  final List<UserEntity> recentSearchedList;
  LoadedChatUserState(
      {required this.usersList,
      required this.currentUserData,
      required this.recentSearchedList});
}
