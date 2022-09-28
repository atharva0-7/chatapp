import 'package:chat_app_flutter/features/chat/data/datasource/local_datasource/get_recent_user_impl.dart';
import 'package:chat_app_flutter/features/chat/data/datasource/remote_datasource/get_current_user_data.dart';
import 'package:chat_app_flutter/features/chat/data/datasource/remote_datasource/get_messages.dart';
import 'package:chat_app_flutter/features/chat/data/datasource/remote_datasource/send_message.dart';
import 'package:chat_app_flutter/features/chat/data/repositories/get_current_user_data_repositoryimpl.dart';
import 'package:chat_app_flutter/features/chat/data/repositories/get_message_repository_impl.dart';
import 'package:chat_app_flutter/features/chat/data/repositories/get_recent_users_list_repository_impl.dart';
import 'package:chat_app_flutter/features/chat/data/repositories/get_user_repository_impl.dart';
import 'package:chat_app_flutter/features/chat/data/repositories/send_message_repositoryImpl.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_current_user_data_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_messages_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_recent_searched_users_list_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/send_message_repository.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/get_current_user_data_usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/get_recent_searched_users_list_usecase.dart';
import 'package:chat_app_flutter/features/chat/domain/usecase/send_message_usecase.dart';

import 'package:chat_app_flutter/features/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../features/chat/data/datasource/remote_datasource/get_chat_users.dart';
import '../features/chat/domain/usecase/get_chat_users_usecase.dart';
import '../features/chat/domain/usecase/get_messages_usecase.dart';
import '../features/chat/presentation/bloc/get_chat_user_bloc/chat_user_bloc.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer? container;

  static setup() {
    container = KiwiContainer();
    var injector = _$InjectorConfig();
    // _$InjectorConfig()._configure();B
    injector._configure();
  }

  static final resolve = container!.resolve;
  //GetChatUsers
  @Register.factory(GetChatUsersUseCase)
  @Register.factory(GetChatUsersRepository, from: GetChatUsersRepositoryImpl)
  @Register.factory(GetChatUsers, from: GetChatUsersImpl)
  @Register.factory(ChatUserBloc)
//SendMessage
  @Register.factory(SendMessageUseCase)
  @Register.factory(SendMessageRepository, from: SendMessageRepositoryImpl)
  @Register.factory(SendMessageSource, from: SendMessageSourceImpl)
  @Register.factory(SendMessageBloc)

//GetMessages
  @Register.factory(GetMessageUseCase)
  @Register.factory(GetMessageRepository, from: GetMessageRepositoryImpl)
  @Register.factory(GetMessagesSource, from: GetMessagesImpl)

  //GEtCurrentUserData
  @Register.factory(GetCurrentUserDataUseCase)
  @Register.factory(GetCurrentUserDataRepository,
      from: GetCurrentUserDataRepositoryImpl)
  @Register.factory(GetCurrentUserDataSource, from: GetCurrenUserDataImpl)

  //GEtRecentSearchedList
  @Register.factory(GetRecentSearchedUsersUseCase)
  @Register.factory(GetRecentSearchedUsersRepository,
      from: GetRecentSearchedUsersRepositoryImpl)
  @Register.factory(GetRecentSearchedUsersSource,
      from: GetRecentSearchedUsersImpl)
  void _configure();
}
