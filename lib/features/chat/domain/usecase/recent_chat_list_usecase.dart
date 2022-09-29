import 'package:chat_app_flutter/features/chat/domain/entities/recent_chat_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/recent_chat_list_repository.dart';

class RecentChatListUseCase {
  final RecentChatListRepository recentChatListRepository;
  RecentChatListUseCase({required this.recentChatListRepository});
  Future<List<RecentChatEntity>> recentChatListUseCase() {
    return recentChatListRepository.recentChatListRepository();
  }
}
