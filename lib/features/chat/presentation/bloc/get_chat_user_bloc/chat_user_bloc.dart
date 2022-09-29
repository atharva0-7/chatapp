import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/get_current_user_data_usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/get_recent_searched_users_list_usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/recent_chat_list_usecase.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_event.dart';
import 'package:chat_app_flutter/features/chat/presentation/bloc/get_chat_user_bloc/chat_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecase/get_chat_users_usecase.dart';

class ChatUserBloc extends Bloc<ChatUserEvent, ChatUserState> {
  final GetChatUsersUseCase getChatUsersUseCase;
  final GetCurrentUserDataUseCase getCurrentUserDataUseCase;
  final GetRecentSearchedUsersUseCase getRecentSearchedUsersUseCase;
  final RecentChatListUseCase recentChatListUseCase;

  ChatUserBloc(
      {required this.recentChatListUseCase,
      required this.getRecentSearchedUsersUseCase,
      required this.getChatUsersUseCase,
      required this.getCurrentUserDataUseCase})
      : super(InitialChatUserState()) {
    on<GetChatUserEvent>((event, emit) async {
      List<RecentChatEntity> recentChatList =
          await recentChatListUseCase.recentChatListUseCase();
      List<UserEntity> recentSearchedList =
          await getRecentSearchedUsersUseCase.getRecentSearchedUsersUseCase();
      // print(recentSearchedList);
      List<UserEntity> usersList =
          await getChatUsersUseCase.getChatUsersUseCase();

      UserEntity currentUserData =
          await getCurrentUserDataUseCase.getCurrentUserDataUseCase(event.uid);
      emit(LoadedChatUserState(
          recentChatList: recentChatList,
          usersList: usersList,
          currentUserData: currentUserData,
          recentSearchedList: recentSearchedList));
    });
  }
}
