import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:share_post/const/app_colors.dart';
import 'package:share_post/const/app_textstyle.dart';
import 'package:share_post/const/auth_const.dart';
import 'package:share_post/const/bubble_const.dart';

Widget chatBubbleWidget(DocumentSnapshot doc) {
  DateTime dateTime = doc['createdAT'] == null
      ? DateTime.parse(DateTime.now().toString())
      : DateTime.parse(doc['createdAT'].toDate().toString());
  return Directionality(
    textDirection:
        doc['uid'] == user!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: doc['uid'] == user!.uid
                          ? AppColors.secondary
                          : AppColors.grey,
                      borderRadius:
                          doc['uid'] == user!.uid ? kfriendBuble : kuserBuble),
                  child: Text(
                    doc['msg'],
                    style: AppTextStyle.regularBlack14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Directionality(
              textDirection: doc['uid'] == user!.uid
                  ? TextDirection.ltr
                  : TextDirection.ltr,
              child: Text(
                intl.DateFormat('EE h:mm a').format(dateTime),
                style:
                    AppTextStyle.regularBlack10.copyWith(color: AppColors.grey),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
