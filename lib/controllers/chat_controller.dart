import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/auth_const.dart';

class ChatController extends GetxController {
  final messageC = TextEditingController();
  var getDoc = firebaseFirestore.collection(collectionChats);
  RxString roomID = ''.obs;
  var userID = user!.uid;
  var userName = user!.displayName;
  var friendID = Get.arguments[1];
  var friendName = Get.arguments[0];

  getChatID() {
    getDoc
        .where('users', isEqualTo: {userID: null, friendID: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot snap) {
            if (snap.docs.isNotEmpty) {
              roomID(snap.docs.single.id);
            } else {
              getDoc.add({
                'users': {userID: null, friendID: null},
                'friend_name': friendName,
                'user_name': userName,
                'toID': '',
                'fromID': '',
                'createdAT': null,
                'last_msg': ''
              }).then((value) {
                roomID(value.id);
              });
            }
          },
        );
  }

  sendMessage(String msg) {
    if (msg.trim().isNotEmpty) {
      getDoc.doc(roomID.value).update({
        'createdAT': FieldValue.serverTimestamp(),
        'fromID': userID,
        'toID': friendID,
        'last_msg': msg,
      });
      getDoc.doc(roomID.value).collection(collectionMessages).doc().set({
        'createdAT': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': userID,
      }).then((value) {
        messageC.clear();
      });
    }
  }

  getMessages(String id) {
    if (id.isNotEmpty) {
      var data = FirebaseFirestore.instance
          .collection(collectionChats)
          .doc(id)
          .collection(collectionMessages)
          .orderBy('createdAT', descending: true)
          .snapshots();
      return data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getChatID();
  }
}
