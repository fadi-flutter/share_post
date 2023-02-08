import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/controllers/get_posts_controller.dart';
import 'package:share_post/views/components/post_widget.dart';
import '../../const/app_colors.dart';
import '../../const/app_textstyle.dart';
import '../components/simple_textfield.dart';
import 'add_post_screen.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final TextEditingController searchC = TextEditingController();
  var controller = Get.put(GetPostsController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(createPostWidget());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 0,
        title: Text(
          'Community Forum',
          style: AppTextStyle.regularWhite18,
        ),
      ),
      body: StreamBuilder(
        stream: controller.getPosts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 16, left: 14, right: 14),
                      child: SimpleTextField(
                        width: width,
                        controller: searchC,
                        hint: 'Find posts by topic...',
                        trailing: Icons.search,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.secondary.withOpacity(0.6),
                            ),
                            child: Text(
                              'Recent',
                              style: AppTextStyle.regularBlack14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.secondary.withOpacity(0.2),
                            ),
                            child: Text(
                              'Most Popular',
                              style: AppTextStyle.regularBlack14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.secondary.withOpacity(0.2),
                            ),
                            child: Text(
                              'My Posts',
                              style: AppTextStyle.regularBlack14,
                            ),
                          ),
                          const Icon(Icons.filter),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 16, right: 16),
                        itemBuilder: ((context, index) {
                          var docs = snapshot.data!.docs[index];
                          return PostWidget(
                            docs: docs,
                            controller: controller,
                          );
                        }),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
