import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/controllers/get_posts_controller.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.docs, required this.controller});
  final DocumentSnapshot docs;
  final GetPostsController controller;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(3, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.secondary.withOpacity(0.2),
                    child: const Icon(
                      Icons.man,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        docs['user_name'],
                        style: AppTextStyle.mediumBlack14,
                      ),
                      Text(
                        docs['created_at'],
                        style: AppTextStyle.regularBlack12
                            .copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                docs['description'],
                style: AppTextStyle.regularBlack14,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StreamBuilder(
                  stream: controller.getLikes(docs.id),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.giveLike(docs.id);
                                },
                                child: Icon(Icons.arrow_upward,
                                    size: 32,
                                    color: snapshot.data!.docs.every(
                                            // ignore: unrelated_type_equality_checks
                                            (element) => element == user!.uid)
                                        ? AppColors.grey
                                        : AppColors.secondary),
                              ),
                              Text(
                                '${snapshot.data!.docs.length}',
                                style: AppTextStyle.mediumBlack12
                                    .copyWith(color: AppColors.grey),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
              const SizedBox(
                width: 14,
              ),
              StreamBuilder(
                  stream: controller.getDisLikes(docs.id),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.giveDisLike(docs.id);
                                },
                                child: Icon(Icons.arrow_downward,
                                    size: 32,
                                    color: snapshot.data!.docs.every(
                                            // ignore: unrelated_type_equality_checks
                                            (element) => element == user!.uid)
                                        ? AppColors.grey
                                        : AppColors.secondary),
                              ),
                              Text(
                                '${snapshot.data!.docs.length}',
                                style: AppTextStyle.mediumBlack12
                                    .copyWith(color: AppColors.grey),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
