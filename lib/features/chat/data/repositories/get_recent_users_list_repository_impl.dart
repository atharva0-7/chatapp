import 'package:chat_app_flutter/features/chat/data/datasource/local/get_recent_user_impl.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

import '../../domain/repository/get_recent_searched_users_list_repository.dart';

class GetRecentSearchedUsersRepositoryImpl
    extends GetRecentSearchedUsersRepository {
  GetRecentSearchedUsersSource getRecentSearchedUsersSource;
  GetRecentSearchedUsersRepositoryImpl(
      {required this.getRecentSearchedUsersSource});
  @override
  Future<Set<UserEntity>> getRecentSearchedUsersRepository() {
    return getRecentSearchedUsersSource.getRecentSearchedUsersSource();
  }
}
