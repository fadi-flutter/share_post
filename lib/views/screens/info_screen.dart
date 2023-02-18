import 'package:flutter/material.dart';
import 'package:share_post/const/app_textstyle.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Forum Screen',
          style: AppTextStyle.boldBlack16,
        ),
      ),
    );
  }
}
