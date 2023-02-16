import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/controllers/posts_controller.dart';
import 'package:share_post/views/components/material_button.dart';

class createPostWidget extends StatelessWidget {
  createPostWidget({super.key});
  var addpostController = Get.put(PostsController());
  @override
  Widget build(BuildContext context) {
    final sizew = MediaQuery.of(context).size.width * 1;
    final sizeh = MediaQuery.of(context).size.height * 1;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: sizew * 0.050, vertical: sizeh * 0.026),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create New Post',
              style: AppTextStyle.mediumBlack18,
            ),
            SizedBox(
              height: sizeh * 0.018,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightGrey,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: addpostController.descriptionC,
                autofocus: false,
                maxLines: null,
                style: const TextStyle(fontSize: 16, color: AppColors.primary),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: AppTextStyle.regularBlack16
                      .copyWith(color: AppColors.grey),
                ),
              ),
            ),
            SizedBox(
              height: sizeh * 0.040,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButtonWidget(
                  onPressed: () {
                    Get.back();
                  },
                  text: Text(
                    'Cancel',
                    style: AppTextStyle.regularBlack14,
                  ),
                  color: AppColors.white,
                  height: sizeh * 0.045,
                  width: sizew * 0.25,
                ),
                SizedBox(
                  width: sizew * 0.020,
                ),
                MaterialButtonWidget(
                  onPressed: () {
                    addpostController.createPost();
                  },
                  text: Text(
                    'Create',
                    style: AppTextStyle.regularWhite14,
                  ),
                  color: AppColors.black,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
