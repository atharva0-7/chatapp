// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configure() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => GetChatUsersUseCase(
          getChatUsersRepository: c<GetChatUsersRepository>()))
      ..registerFactory<GetChatUsersRepository>(
          (c) => GetChatUsersRepositoryImpl(getChatUsers: c<GetChatUsers>()))
      ..registerFactory<GetChatUsers>((c) => GetChatUsersImpl())
      ..registerFactory((c) => ChatUserBloc(
          recentChatListUseCase: c<RecentChatListUseCase>(),
          getRecentSearchedUsersUseCase: c<GetRecentSearchedUsersUseCase>(),
          getChatUsersUseCase: c<GetChatUsersUseCase>(),
          getCurrentUserDataUseCase: c<GetCurrentUserDataUseCase>()))
      ..registerFactory((c) =>
          SendMessageUseCase(sendMessageRepository: c<SendMessageRepository>()))
      ..registerFactory<SendMessageRepository>((c) =>
          SendMessageRepositoryImpl(sendMessageSource: c<SendMessageSource>()))
      ..registerFactory<SendMessageSource>((c) => SendMessageSourceImpl())
      ..registerFactory((c) => SendMessageBloc(
          sendMessageUseCase: c<SendMessageUseCase>(),
          getMessageUseCase: c<GetMessageUseCase>()))
      ..registerFactory((c) =>
          GetMessageUseCase(getMessageRepository: c<GetMessageRepository>()))
      ..registerFactory<GetMessageRepository>((c) =>
          GetMessageRepositoryImpl(getMessagesSource: c<GetMessagesSource>()))
      ..registerFactory<GetMessagesSource>((c) => GetMessagesImpl())
      ..registerFactory((c) => GetCurrentUserDataUseCase(
          getCurrentUserRepository: c<GetCurrentUserDataRepository>()))
      ..registerFactory<GetCurrentUserDataRepository>((c) =>
          GetCurrentUserDataRepositoryImpl(
              getCurrentUserDataSource: c<GetCurrentUserDataSource>()))
      ..registerFactory<GetCurrentUserDataSource>(
          (c) => GetCurrenUserDataImpl())
      ..registerFactory((c) => GetRecentSearchedUsersUseCase(
          getRecentSearchedUsersRepository:
              c<GetRecentSearchedUsersRepository>()))
      ..registerFactory<GetRecentSearchedUsersRepository>((c) =>
          GetRecentSearchedUsersRepositoryImpl(
              getRecentSearchedUsersSource: c<GetRecentSearchedUsersSource>()))
      ..registerFactory<GetRecentSearchedUsersSource>(
          (c) => GetRecentSearchedUsersImpl())
      ..registerFactory((c) => RecentChatListUseCase(
          recentChatListRepository: c<RecentChatListRepository>()))
      ..registerFactory<RecentChatListRepository>((c) =>
          RecentChatListRepositoryImpl(recentChatSource: c<RecentChatSource>()))
      ..registerFactory<RecentChatSource>((c) => RecentChatSourceImpl());
  }
}
