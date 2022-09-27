import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';
import 'package:chat_app_flutter/features/chat/domain/repository/get_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../repository/get_current_user_data_repository.dart';

class GetCurrentUserDataUseCase {
  GetCurrentUserDataRepository getCurrentUserRepository;
  GetCurrentUserDataUseCase({required this.getCurrentUserRepository});

  Future<UserEntity> getCurrentUserDataUseCase(String uid) {
    return getCurrentUserRepository.getCurrentUserDataRepository(uid);
  }
}
