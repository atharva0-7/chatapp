import 'package:chat_app_flutter/features/chat/data/datasource/remote_datasource/recent_chats.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';

import '../../domain/repository/recent_chat_list_repository.dart';

class RecentChatListRepositoryImpl implements RecentChatListRepository {
  final RecentChatSource recentChatSource;
  RecentChatListRepositoryImpl({required this.recentChatSource});
  @override
  Future<List<RecentChatEntity>> recentChatListRepository() {
    return recentChatSource.getRecentChatsSource();
  }
}
