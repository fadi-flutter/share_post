import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_post/const/auth_const.dart';

class AddPostController extends GetxController {
  final descriptionC = TextEditingController();
  RxString time = ''.obs;
  createPost() async {
    await convertDate();
    await firebaseFirestore.collection(collectionPosts).add({
      'created_at': time.value,
      'user_id': user!.uid,
      'user_name': user!.displayName,
      'description': descriptionC.text,
    }).then((value) {
      descriptionC.clear();
      Get.back();
    });
  }

  convertDate() {
    DateFormat dateFormat = DateFormat('EEEE, h:mm a');
    time.value = dateFormat.format(DateTime.now());
  }
}
