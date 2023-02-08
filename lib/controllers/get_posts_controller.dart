import 'package:get/get.dart';
import 'package:share_post/const/auth_const.dart';

class GetPostsController extends GetxController {
  getPosts() {
    return firebaseFirestore
        .collection(collectionPosts)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  giveLike(String id) async {
    await firebaseFirestore
        .collection(collectionPosts)
        .doc(id)
        .collection(collectionLikes)
        .add({
      'user_id': user!.uid,
    });
  }

  giveDisLike(String id) async {
    await firebaseFirestore
        .collection(collectionPosts)
        .doc(id)
        .collection(collectionDislikes)
        .add({
      'user_id': user!.uid,
    });
  }

  getLikes(String id) {
    return firebaseFirestore
        .collection(collectionPosts)
        .doc(id)
        .collection(collectionLikes)
        .snapshots();
  }
  getDisLikes(String id) {
    return firebaseFirestore
        .collection(collectionPosts)
        .doc(id)
        .collection(collectionDislikes)
        .snapshots();
  }
}
