import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

import '../../domain/repository/get_recent_searched_users_list_repository.dart';
import '../datasource/local_datasource/get_recent_user_impl.dart';

class GetRecentSearchedUsersRepositoryImpl
    implements GetRecentSearchedUsersRepository {
  final GetRecentSearchedUsersSource getRecentSearchedUsersSource;
  GetRecentSearchedUsersRepositoryImpl(
      {required this.getRecentSearchedUsersSource});
  @override
  Future<List<UserEntity>> getRecentSearchedUsersRepository() {
    return getRecentSearchedUsersSource.getRecentSearchedUsersSource();
  }
}
