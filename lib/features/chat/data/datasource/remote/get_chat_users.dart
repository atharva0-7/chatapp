import 'package:chat_app_flutter/features/chat/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetChatUsers {
  Future<List<UserModel>> getSourceChatUsers();
}

class GetChatUsersImpl extends GetChatUsers {
  @override
  Future<List<UserModel>> getSourceChatUsers() {
    return getUsers();
  }

  Future<List<UserModel>> getUsers() async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await collectionRef.get();
      final allData =
          querySnapshot.docs.map((doc) => UserModel.fromJson(doc)).toList();

      return allData;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
