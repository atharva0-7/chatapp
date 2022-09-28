import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_recent_searched_users_list_repository.dart';

class GetRecentSearchedUsersUseCase {
  final GetRecentSearchedUsersRepository getRecentSearchedUsersRepository;
  GetRecentSearchedUsersUseCase(
      {required this.getRecentSearchedUsersRepository});

  Future<List<UserEntity>> getRecentSearchedUsersUseCase() {
    return getRecentSearchedUsersRepository.getRecentSearchedUsersRepository();
  }
}
