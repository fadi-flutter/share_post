import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/models/get_posts_model.dart';

class GetPostsController extends GetxController {
  var postsList = <GetPostModel>[].obs;
  final doc = firebaseFirestore.collection(collectionPosts);

  Stream<List<GetPostModel>> getPosts() {
    return doc.orderBy('created_at', descending: true).snapshots().map(
        (querySnap) =>
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
