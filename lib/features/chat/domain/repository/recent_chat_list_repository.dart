import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

abstract class RecentChatListRepository {
  Future<List<RecentChatEntity>> recentChatListRepository();
}
