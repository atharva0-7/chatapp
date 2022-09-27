import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String firstName;
  String lastName;
  String uid;
  String phoneNumber;

  UserEntity(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.uid});
  // factory UserEntity.fromRawJson(String str) =>
  //     UserEntity.fromJson(json.decode(str));

  // factory UserEntity.fromJson(QueryDocumentSnapshot<Object?> json) {
    
  //   return UserEntity(
  //       firstName: json["first_name"],
  //       lastName: json["last_name"],
  //       phoneNumber: json["phone_number"],
  //       uid: json["uid"]);
  // }
}
