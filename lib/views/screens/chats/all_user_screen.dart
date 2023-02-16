import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/views/screens/chats/chat_screen.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Friends',
          style: AppTextStyle.boldWhite20,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firebaseFirestore
                    .collection(collectionUsers)
                    .where('id', isNotEqualTo: user!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 20, left: 14, right: 14),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var docs = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => ChatScreen(
                                          friendName: docs['name'],
                                        ),
                                    arguments: [docs['name'], docs['id']]);
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.secondary.withOpacity(0.3),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          AppColors.secondary.withOpacity(0.2),
                                      child: const Icon(
                                        Icons.man,
                                        color: AppColors.secondary,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          docs['name'],
                                          style: AppTextStyle.mediumBlack16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
