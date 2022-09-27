import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';

abstract class GetCurrentUserDataSource {
  Future<UserModel> currentUserDataSource(String uid);
}

class GetCurrenUserDataImpl extends GetCurrentUserDataSource {
  @override
  Future<UserModel> currentUserDataSource(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> currentUserData =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // print(currentUserData.data());

    UserModel userModel = UserModel.fromJson(currentUserData.data());

    return userModel;
  }
}
