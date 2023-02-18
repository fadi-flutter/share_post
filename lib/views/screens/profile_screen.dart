import 'package:flutter/material.dart';
import 'package:share_post/const/app_textstyle.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Screen',
          style: AppTextStyle.boldBlack16,
        ),
      ),
    );
  }
}
