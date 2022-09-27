import 'package:chat_app_flutter/features/chat/data/datasource/remote/get_current_user_data.dart';
import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/get_current_user_data_repository.dart';

class GetCurrentUserDataRepositoryImpl extends GetCurrentUserDataRepository {
  GetCurrentUserDataSource getCurrentUserDataSource;
  GetCurrentUserDataRepositoryImpl({required this.getCurrentUserDataSource});
  @override
  Future<UserEntity> getCurrentUserDataRepository(String uid) {
    return getCurrentUserDataSource.currentUserDataSource(uid);
  }
}
