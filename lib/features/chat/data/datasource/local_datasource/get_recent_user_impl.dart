import 'dart:convert';

import '../../../../../utils/shared_prefrences.dart';
import '../../models/user_model.dart';

abstract class GetRecentSearchedUsersSource {
  Future<List<UserModel>> getRecentSearchedUsersSource();
}

class GetRecentSearchedUsersImpl implements GetRecentSearchedUsersSource {
  @override
  Future<List<UserModel>> getRecentSearchedUsersSource() async {
    String? recentSearchedDataString =
        await SharedPref.getRecentSearchedUsers();
    if (recentSearchedDataString == null || recentSearchedDataString.isEmpty) {
      return [];
    }
    List recentSearchedDataList = (jsonDecode(recentSearchedDataString));
    List<UserModel> list =
        recentSearchedDataList.map((e) => UserModel.fromLocal(e)).toList();

    return list;
  }
}
