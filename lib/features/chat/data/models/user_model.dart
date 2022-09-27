import 'dart:convert';

import 'package:chat_app_flutter/features/chat/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required String firstName,
      required String lastName,
      required String phoneNumber,
      required String uid})
      : super(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            uid: uid);

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(json) {
    return UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        uid: json["uid"]);
  }

  factory UserModel.fromLocal(local) {
    return UserModel(
        firstName: local["firstName"],
        lastName: local["lastName"],
        phoneNumber: local["phoneNumber"],
        uid: local["uid"]);
  }
  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "uid": uid,
      };
}
