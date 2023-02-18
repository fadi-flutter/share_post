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
  final userUid = firebaseAuth.currentUser!.uid;

  final descriptionC = TextEditingController();
  RxString time = ''.obs;
  createPost() async {
    await convertDate();
    await firebaseFirestore.collection(collectionPosts).add({
      'time_stamp': DateTime.now(),
      'created_at': time.value,
      'user_id': userUid,
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
    if (post.likes.contains(userUid)) {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userUid])
      });
    } else if (post.disLikes.contains(userUid)) {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayRemove([userUid])
      });
      doc.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userUid])
      });
    } else {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userUid])
      });
    }
  }

  handelDisLikes(GetPostModel post) {
    if (post.disLikes.contains(userUid)) {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayRemove([userUid])
      });
    } else if (post.likes.contains(userUid)) {
      doc.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userUid])
      });
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayUnion([userUid])
      });
    } else {
      doc.doc(post.id).update({
        'dislikes': FieldValue.arrayUnion([userUid])
      });
    }
  }
}
