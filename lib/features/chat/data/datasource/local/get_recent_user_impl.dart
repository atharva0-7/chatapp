import 'dart:convert';

import '../../../../../utils/shared_prefrences.dart';
import '../../models/user_model.dart';

abstract class GetRecentSearchedUsersSource {
  Future<Set<UserModel>> getRecentSearchedUsersSource();
}

class GetRecentSearchedUsersImpl extends GetRecentSearchedUsersSource {
  @override
  Future<Set<UserModel>> getRecentSearchedUsersSource() async {
    String? recentSearchedDataString =
        await SharedPref.getRecentSearchedUsers();
    if (recentSearchedDataString == null || recentSearchedDataString.isEmpty) {
      return {};
    }
    List recentSearchedDataList = (jsonDecode(recentSearchedDataString));
    //  recentSearchedDataList.map((e) => );
    print(recentSearchedDataList);
    Set<UserModel> list =
        recentSearchedDataList.map((e) => UserModel.fromLocal(e)).toSet();
    // print(list[0].firstName);

    return list;

    // print(userList);
  }
}
