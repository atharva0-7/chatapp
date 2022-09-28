import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import '../../domain/repository/get_current_user_data_repository.dart';
import '../datasource/remote_datasource/get_current_user_data.dart';

class GetCurrentUserDataRepositoryImpl implements GetCurrentUserDataRepository {
  final GetCurrentUserDataSource getCurrentUserDataSource;
  GetCurrentUserDataRepositoryImpl({required this.getCurrentUserDataSource});
  @override
  Future<UserEntity> getCurrentUserDataRepository(String uid) {
    return getCurrentUserDataSource.currentUserDataSource(uid);
  }
}
