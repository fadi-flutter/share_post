import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/controllers/get_posts_controller.dart';
import 'package:share_post/models/get_posts.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.controller, required this.post});
  final GetPostsController controller;
  final GetPostModel post;
  final doc = firebaseFirestore.collection(collectionPosts);
  User? user = firebaseAuth.currentUser;
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
                        post.userName,
                        style: AppTextStyle.mediumBlack14,
                      ),
                      Text(
                        post.createdAt,
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
                post.description,
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
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.handelLikes(post);
                      },
                      child: Icon(Icons.arrow_upward,
                          size: 32,
                          color: post.likes.contains(user!.uid)
                              ? AppColors.secondary
                              : AppColors.grey)),
                  //likes
                  Text(
                    post.likes.length.toString(),
                    style: AppTextStyle.mediumBlack12
                        .copyWith(color: AppColors.grey),
                  ),
                ],
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.handelDisLikes(post);
                    },
                    child: Icon(Icons.arrow_downward,
                        size: 32,
                        color: post.disLikes.contains(user!.uid)
                            ? AppColors.secondary
                            : AppColors.grey),
                  ),
                  //dislikes
                  Text(
                    post.disLikes.length.toString(),
                    style: AppTextStyle.mediumBlack12
                        .copyWith(color: AppColors.grey),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
