import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/const/bubble_const.dart';
import 'package:share_post/controllers/chat_controller.dart';
import 'package:share_post/views/screens/chats/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.friendName});
  final String friendName;
  final ChatController chatC = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(friendName, style: AppTextStyle.boldWhite18),
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Obx(
            () {
              return Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: chatC.getMessages(chatC.roomID.value),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  var docs = snapshot.data!.docs[index];
                                  return chatBubbleWidget(docs);
                                },
                                itemCount: snapshot.data!.docs.length,
                                reverse: true,
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: AppColors.black,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                                controller: chatC.messageC,
                                maxLines: 1,
                                decoration: ktextfield)),
                        GestureDetector(
                          onTap: () {
                            chatC.sendMessage(chatC.messageC.text);
                          },
                          child: CircleAvatar(
                            radius: 21,
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.send,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
