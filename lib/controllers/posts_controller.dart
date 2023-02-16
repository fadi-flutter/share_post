import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/models/get_posts.dart';

class PostsController extends GetxController {
  final TextEditingController searchC = TextEditingController();
  RxBool fieldEnabled = false.obs;
  RxInt sortIndex = 0.obs;
  final doc = firebaseFirestore.collection(collectionPosts);

  final descriptionC = TextEditingController();
  RxString time = ''.obs;
  createPost() async {
    await convertDate();
    await firebaseFirestore.collection(collectionPosts).add({
      'time_stamp': DateTime.now(),
      'created_at': time.value,
      'user_id': user!.uid,
      'user_name': user!.displayName,
      'description': descriptionC.text,
      'likes': [],
      'dislikes': [],
    }).then((value) {
      descriptionC.clear();
      Get.back();
    });
  }

  convertDate() {
    DateFormat dateFormat = DateFormat('EEEE, h:mm a');
    time.value = dateFormat.format(DateTime.now());
  }

  Stream<List<GetPostModel>> getAllPosts() {
    return doc.orderBy('time_stamp', descending: true).snapshots().map(
        (querySnap) =>
            querySnap.docs.map((doc) => GetPostModel.fromMap(doc)).toList());
  }

  Stream<List<GetPostModel>> getMyPosts() {
    return doc
        .orderBy('time_stamp', descending: true)
        .where('user_id', isEqualTo: user!.uid)
        .snapshots()
        .map((querySnap) =>
            querySnap.docs.map((doc) => GetPostModel.fromMap(doc)).toList());
  }

  handelLikes(GetPostModel post) {
    if (post.likes.contains(user!.uid)) {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayRemove([user!.uid])
      });
    } else if (post.disLikes.contains(user!.uid)) {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayRemove([user!.uid])
      });
      doc.doc(post.id).update({
        'likes': FieldValue.arrayUnion([user!.uid])
      });
    } else {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayUnion([user!.uid])
      });
    }
  }

  handelDisLikes(GetPostModel post) {
    if (post.disLikes.contains(user!.uid)) {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayRemove([user!.uid])
      });
    } else if (post.likes.contains(user!.uid)) {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayRemove([user!.uid])
      });
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayUnion([user!.uid])
      });
    } else {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayUnion([user!.uid])
      });
    }
  }
}
