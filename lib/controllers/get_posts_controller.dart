import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/models/get_posts.dart';

class GetPostsController extends GetxController {
  final TextEditingController searchC = TextEditingController();
  RxBool fieldEnabled = false.obs;
  RxInt sortIndex = 0.obs;
  final doc = firebaseFirestore.collection(collectionPosts);

  Stream<List<GetPostModel>> getAllPosts() {
    return doc.orderBy('created_at', descending: false).snapshots().map(
        (querySnap) =>
            querySnap.docs.map((doc) => GetPostModel.fromMap(doc)).toList());
  }

  Stream<List<GetPostModel>> getMyPosts() {
    return doc
        .orderBy('created_at', descending: false)
        .where('user_id', isEqualTo: user!.uid)
        .snapshots()
        .map((querySnap) => querySnap.docs.map((doc) => GetPostModel.fromMap(doc)).toList());
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
