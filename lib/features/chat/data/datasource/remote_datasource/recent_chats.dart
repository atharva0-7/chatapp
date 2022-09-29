import 'dart:async';

import 'package:chat_app_flutter/features/chat/data/datasource/remote_datasource/get_current_user_data.dart';
import 'package:chat_app_flutter/features/chat/data/models/recent_chat_model.dart';
import 'package:chat_app_flutter/features/chat/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RecentChatSource {
  Future<List<RecentChatModel>> getRecentChatsSource();
}

class RecentChatSourceImpl implements RecentChatSource {
  @override
  Future<List<RecentChatModel>> getRecentChatsSource() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    List<String> receiverUidList = [];
    GetCurrenUserDataImpl getCurrenUserDataImpl = GetCurrenUserDataImpl();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('chats').get();
    List<QueryDocumentSnapshot> currentChatUsers = querySnapshot.docs;
    List<Map> mappedData = [];
    for (QueryDocumentSnapshot data in currentChatUsers) {
      if (data.get('uid').toString().contains(currentUser.uid)) {
        mappedData.add(data.data() as Map);
      }
    }
    for (Map map in mappedData) {
      late String tempUid;
      if (map['uid1'] == currentUser.uid) {
        tempUid = map['uid2'];
      } else {
        tempUid = map['uid1'];
      }
      receiverUidList.add(tempUid);
    }
    List<UserModel> receiverUserUserEntityList = [];
    for (String uid in receiverUidList) {
      UserModel userEntity =
          await getCurrenUserDataImpl.currentUserDataSource(uid);
      receiverUserUserEntityList.add(userEntity);
    }
    // print(receiverUidList);

    // print(mappedData);
    List<Map> mappedDataList = [];
    int count = 0;
    for (Map map in mappedData) {
      String currentUid = map['uid'];

      UserModel currentReciverUser = receiverUserUserEntityList[count];
      Stream<QuerySnapshot<Map<String, dynamic>>> messages = FirebaseFirestore
          .instance
          .collection('chats')
          .doc(currentUid)
          .collection('messages')
          // .where('sentBy',
          //     isEqualTo:
          //         "${currentReciverUser.firstName} ${currentReciverUser.lastName}")
          .orderBy('dateTime', descending: true)
          .limit(1)
          .snapshots();
      count++;
      // List<QueryDocumentSnapshot<Map<String, dynamic>>> messagesList =
      //     messages.;

      Map<String, dynamic> mappedMessages = {
        "receivingUser": currentReciverUser,
        "latestMessage": messages
      };
      mappedDataList.add(mappedMessages);
    }

    List<RecentChatModel> recentChatData =
        mappedDataList.map((e) => RecentChatModel.fromJson(e)).toList();

    return recentChatData;
  }
}
